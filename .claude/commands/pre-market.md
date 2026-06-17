---
description: Run pre-market research locally (v2). Reflects on yesterday, regime + catalyst + quant, writes RESEARCH-LOG / PENDING-TRADES / LEARNING-LOG, notifies ClickUp.
---

You are running the pre-market research workflow locally using the .env credentials.
Goal: grow the account as fast as is *survivable* (absolute return). Catalyst-led,
quant-confirmed swing trader. Instruments: stocks, ETFs, leveraged ETFs, inverse ETFs.
NO options. Long-only. Ultra-concise — short bullets, no fluff.
Resolve today's date: DATE=$(date +%Y-%m-%d). Scripts auto-source .env — never print keys.

STEP 1 — Read memory:
- memory/TRADING-STRATEGY.md (the full rulebook — follow it exactly)
- tail memory/TRADE-LOG.md (open positions, entries, stops, ATR, week trade count, peak equity)
- tail memory/RESEARCH-LOG.md (yesterday's context)
- head memory/LEARNING-LOG.md (recent scorecards — feeds the STEP 3b reflection / soft bias)

STEP 2 — Account state + drawdown breaker:
  bash scripts/alpaca.sh account
  bash scripts/alpaca.sh positions
  bash scripts/alpaca.sh orders
Compute equity and drawdown from peak (peak = highest equity in TRADE-LOG EOD snapshots).
If equity is ≥20% below peak → DRAWDOWN BREAKER: no new trades. Write HOLD, notify, exit.

STEP 3 — Market regime (Alpaca data, not headlines):
  bash scripts/quant.sh regime          # SPY  → risk_on / neutral / risk_off
Risk-off equity regime → no new long equity (only inverse-ETF setups allowed).
Neutral → half size, best setups only.

STEP 3b — Reflect on yesterday & update the learning log (self-improvement loop):
Goal: score yesterday's research against what ACTUALLY moved, so today is smarter.
- Read yesterday's entry in memory/RESEARCH-LOG.md (its candidates + decision) and the
  last ~7 scorecards at the top of memory/LEARNING-LOG.md.
- If there is no prior RESEARCH-LOG entry and no log history → write one line under the
  divider in LEARNING-LOG.md: "## $DATE — first run, baseline, no history yet" and skip
  the rest of this step.
- Pull yesterday's actual movers:  bash scripts/alpaca.sh movers 25
  Filter to a TRADEABLE universe before learning anything: keep price ≥ $5 and DROP
  warrants/units/rights (heuristic: 5-letter symbols ending in W, or symbols ending in
  U or R). Keep ~10 gainers + ~5 losers.
- Score our own picks: for each ticker we proposed/held yesterday, get its real 1-day
  move via  bash scripts/alpaca.sh bars TICKER 5  (last bar vs prior close). Tag each:
  worked / stopped / missed-entry / dodged-loss.
- Best realistic miss: among the filtered gainers, pick the single highest-quality name
  that had an identifiable catalyst AND would plausibly have passed quant — the trade we
  SHOULD have surfaced. Ignore penny pumps and unexplained spikes; we never chase those.
- Prepend a dated block to the top of memory/LEARNING-LOG.md (newest first), under the
  "---" divider, exactly:
## $DATE — Scorecard (prior session $PREV_DATE)
### Our picks: TICKER — decision(traded/pending/rejected) — actual 1d ±X% — verdict
### Day's top tradeable gainers: TICKER +X% ($price) — sector/theme  (repeat ~5)
### Best realistic miss: TICKER +X% — sector — catalyst? would-pass-quant? why we missed it
### Lessons: up to 3 short bullets
### Rolling 7d: recurring leading sectors = [...] ; recurring miss pattern = [...]
Carry the rolling-7d line forward by aggregating across the last 7 scorecards.
These lessons are a SOFT bias for the steps below — they never relax a hard rule.

STEP 4 — Catalyst research (Perplexity; on exit code 3 fall back to WebSearch and note it):
  bash scripts/perplexity.sh "<query>"
- "Top premarket stock movers today $DATE by volume and why — surging stocks and catalysts"
- "Market-moving news today $DATE — earnings beats, raised guidance, contract wins, upgrades, FDA, M&A"
- "S&P 500 sector leadership this week $DATE — leading and lagging sectors"
- "S&P 500 futures and VIX premarket today $DATE"
- "WTI and Brent crude oil and key commodity moves today $DATE"
- "Economic calendar today $DATE — CPI PPI FOMC jobs, any major release"
- For each held ticker: "[TICKER] news today $DATE — is the catalyst still valid?"
- If equity regime is risk-off: "Is the broad market breaking down today $DATE — downtrend confirmation"
- SOFT BIAS from STEP 3b: add a query focused on the sector(s) recurring as leaders in the
  rolling-7d view, and one probing any repeated-miss theme — so we stop missing the same setups.
Use Perplexity ONLY for the qualitative catalyst. NEVER use its prices/percentages for
decisions — every number comes from Alpaca in STEP 5.

STEP 5 — Quant-confirm each catalyst name (ALPACA bars only):
  bash scripts/quant.sh signal TICKER           # stocks / ETFs / leveraged & inverse ETFs (benchmark SPY)
This routine trades EQUITY INSTRUMENTS ONLY (stocks, ETFs, leveraged ETFs, inverse ETFs).
A name is a candidate only if: catalyst present AND "confirmed": true
(passes ≥3/5) AND its regime allows it (inverse ETFs only in risk-off). The helper returns
suggested_stop (entry−2×ATR) and risk_per_share — use them next.

STEP 6 — Size each candidate (% of equity per TRADING-STRATEGY):
- risk_dollars = 0.03 × equity
- shares = risk_dollars ÷ risk_per_share (fractional OK for stocks/ETFs)
- position_value = shares × last; cap at 25% of equity AND sleeve caps
  (leveraged/inverse ETF ≤15%). Trim shares to fit.
- Confirm reward:risk ≥ 2:1 (≥ 2× risk_per_share of room to a sensible objective).
Respect: ≤3–4 total positions, portfolio heat ≤12% (sum of open 3% risks), ≤2 per theme.
SOFT BIAS from STEP 3b (tiebreaker only): between two otherwise-equal candidates, prefer
the one in a recurring-leading sector, and be warier of a setup pattern that has repeatedly
failed in the log. Hard rules are NEVER relaxed by these lessons.

STEP 7 — Write a dated entry to memory/RESEARCH-LOG.md:
## $DATE — Pre-market
### Account: equity / cash / drawdown-from-peak / open positions / week trades
### Regime: equity [risk_on/neutral/off]
### Candidates (passed catalyst + quant):
TICKER (sleeve) — catalyst: X — quant N/5 — entry ~$X | stop $X (−2ATR) | risk/sh $X | shares X | $X (X% eq) | R:R X:1
### Rejected: TICKER — reason (no catalyst / quant N/5 / regime / caps)
### Decision: TRADE [tickers] or HOLD (reason)

STEP 8 — Overwrite memory/PENDING-TRADES.md:
If trades:
# Pending Trades — $DATE
## Veto: delete a block before 3:30 PM Paris / 9:30 AM ET on GitHub.
### BUY TICKER — N shares — ~$X (X% eq) — [sleeve]
- Catalyst: X | quant N/5 | entry ~$X | stop $X (−2×ATR) | risk/sh $X | R:R X:1
(repeat per trade)
If none:
# Pending Trades — $DATE
No trades. Reason: [one line].

STEP 9 — ALWAYS notify ClickUp. MOBILE layout: each field on its own short line, bold the
title/section/ticker lines, "·" as the in-line separator, NO emojis, NO 4-space indents.
Date as DD-MM-YYYY. Tag the instrument type after the ticker: (stock) (ETF) (leveraged ETF)
(inverse ETF). $[amount] = dollars in the position; $[price] = per-share price.
Include a macro line (Oil/VIX/futures) ONLY when it is notably moving or directly relevant
to a planned trade — otherwise omit it (Leading sectors is enough). The "Why" must be plain
English explaining what is actually driving the move — no jargon. If trades are planned:
  bash scripts/clickup.sh "**Pre-market [DD-MM-YYYY]** (for [Weekday DD-MM] open)
eq [risk_on/neutral/off]
DD from peak: [X]%
Equity: \$[X]
Leading sectors: [top sectors]

**Planned trades**

**BUY [TICKER]** ([type])
[N] sh · ~\$[amount] ([X]% eq)
Entry ~\$[price]
Stop \$[price] (-2 ATR)
Target ~\$[price] (R:R [X]:1)
Quant [N]/5 · Risk ~\$[X] ([X]% eq)
Why: [plain-English reason — what is driving it, one short line]

(repeat the BUY block per trade)

Veto: delete the block in PENDING-TRADES.md before 3:30 PM Paris"
If NO trades, send instead:
  bash scripts/clickup.sh "**Pre-market [DD-MM-YYYY]** (for [Weekday DD-MM] open)
eq [X]
DD from peak: [X]%
Equity: \$[X]
Leading sectors: [top sectors]

No trades today.
Reason: [one line]"

STEP 10 — Persist (local run): show the diff and commit when satisfied:
  git add memory/RESEARCH-LOG.md memory/PENDING-TRADES.md memory/LEARNING-LOG.md
  git commit -m "pre-market research $DATE" && git push origin main
(Local is on main, so a plain `git push origin main` is correct here — no HEAD:main needed.)
