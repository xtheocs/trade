# Trading Strategy

## Mission
Grow the account as fast as is *survivable*. Absolute return — not measured against
the S&P 500. Survive first, compound second: a blown-up account can't compound.
Style: **catalyst-driven swing trading (days to weeks), quant-confirmed.**

**Target:** ~10%/month is the *stretch* aim for a good month; ~3–5% is a solid month;
red months are normal. There is **no floor** — never break a risk rule to hit a number.

Currently $100k paper; the live account will be small (<$1k). Every rule is written
in **% of equity**, so the same strategy runs identically at any account size.
This file is updated by the weekly review when rules prove out or fail over 2+ weeks.

---

## Capital & Constraints
- **Sizing is always % of current equity — never fixed dollars** (scales paper → live).
- Live account <$1k → **cash account, no margin** (margin needs $2k). Leverage comes
  only from leveraged ETFs and instrument volatility — never borrowed money.
- **PDT-aware:** under $25k equity = max 3 day-trades per 5 business days. We swing
  (hold overnight), so day-trades stay near zero. Never open+close the same name the
  same day except a stop-out.
- **Instruments allowed:** stocks, ETFs (fractional), leveraged ETFs, inverse ETFs, crypto.
  **NO options. No short selling** — downside is played via inverse ETFs (e.g. SH, SQQQ),
  not short sales (which need margin you won't have).
- **Holding period:** days to a few weeks. Not intraday, not multi-month.

---

## Core Risk Rules (non-negotiable)
1. **Risk per trade ≤ 3% of equity** — the most you lose if the stop hits. Master dial.
2. **Portfolio heat ≤ 12%** — sum of open risk across all positions (≈ four 3% trades).
3. **Max 3–4 concurrent positions.**
4. **Drawdown circuit breaker:** if equity falls **20% below its peak**, STOP opening
   new trades, alert the owner, and only manage existing positions until owner resumes.
5. **Minimum reward:risk 2:1** on every entry (target 2–3:1).
6. **Position size = (0.03 × equity) ÷ per-share stop distance**, hard-capped at
   **25% of equity** per position (smaller for crypto / leveraged ETFs — see below).
7. Every position gets a **protective stop placed immediately after fill.**
8. **Cut at the stop. No exceptions, no averaging down, no hoping.**
9. Never move a stop down. Never widen a stop. Only tighten.
10. **Time stop:** no meaningful progress after ~7 trading days → close, free the capital.
11. Patience > activity. Zero trades is a valid week. On a small account, overtrading
    bleeds you through spreads.

---

## Market Regime Filter (check before ANY new long)
Computed from **Alpaca price data**, not headlines.

**Equity / ETF regime — SPY vs its 50-day SMA:**
- **Risk-on** (SPY above a rising 50-day): trade long equity / ETFs normally.
- **Neutral** (SPY chopping around its 50-day): half size, best setups only.
- **Risk-off** (SPY below a falling 50-day, or a sharp broad selloff): **no new long
  equity.** Inverse-ETF longs (SQQQ/SH — capped, held short) ARE allowed here — this is
  the sanctioned way to play the downside. Tighten/trim existing longs.

**Crypto regime — judged separately, BTC vs its own 50-day SMA:**
- Crypto runs its own cycle, so crypto setups gate on BTC's trend, not SPY.
- BTC above a rising 50-day → crypto risk-on. BTC below a falling 50-day → no new crypto.

Don't fight the tape — most momentum trades fail against their own regime.

---

## Entry Method — Catalyst-led, Quant-confirmed
A trade needs BOTH a reason and confirmation.

**Step 1 — Catalyst (the reason; from Perplexity/WebSearch):**
A specific, recent event driving the name — earnings beat / raised guidance, contract
win, analyst upgrade, product launch, sector-moving macro or commodity news, regulatory
approval, crypto protocol/flow catalyst. No catalyst → no trade.

**Step 2 — Quant confirmation (the proof; computed from ALPACA BARS ONLY):**
> Never trust prices or percentages quoted by Perplexity. Pull bars from Alpaca and
> compute every number yourself.

Require **at least 3 of 5**:
- **Trend:** price above a rising 20-day SMA.
- **Momentum:** positive 10-day return AND price within ~5% of its 20-day high.
- **Relative strength:** outperforming SPY over the last 10–20 days.
- **Volume:** today's volume above its 20-day average (real participation).
- **Not over-extended:** not more than ~2 ATR above the 20-day SMA (don't chase blow-offs).

*Crypto adaptation:* measure relative strength vs **BTC** (not SPY), and gate on the
crypto regime (BTC's 50-day) from §4. All other checks use the coin's own Alpaca bars.

**Step 3 — Regime check** is risk-on or neutral.

Catalyst + ≥3/5 quant + acceptable regime → candidate for PENDING-TRADES.md.

---

## Stops & Sizing (ATR-based)
- Pull **14-day ATR** from Alpaca. Initial **stop = entry − 2×ATR**.
- **Position size = (0.03 × equity) ÷ (entry − stop)** → auto-shrinks for volatile names.
- Hard cap **25% of equity** per single position, whatever the math says.
- **Target ≥ 2× the stop distance** (enforces the 2:1 minimum).
- The 2:1 is a **setup filter, not a take-profit**: a trade needs ≥2R of room *before*
  entry, but once in, winners are managed by the trailing stop (§7) — never auto-sold at
  exactly 2R. Let winners run; the big runs pay for the losers.

---

## Sell-Side Rules
- **Initial stop hit** → close. No exceptions.
- **Lock gains:** once up ≥ +1×ATR, move stop to breakeven; then trail behind the
  10-day low or by ATR. Tighten as it runs — never loosen.
- **Thesis broken** (catalyst invalidated, sector rolling over, bad news) → close even
  if the stop isn't hit.
- **Time stop:** no meaningful progress in ~7 trading days → close.
- **Regime flips risk-off** → trim and tighten across the book.

---

## Tradeable Universe & Allocation
Keep the book to **3–4 positions**, diversified (no more than ~2 in one theme):

| Sleeve | Role | Max exposure | Notes |
|--------|------|-------------|-------|
| **Stocks** (liquid large/mid-cap) | Core | up to full book | Fractional; single-name catalyst plays |
| **Sector / index ETFs** (SPY, QQQ, XLE, SMH…) | Core / theme | up to full book | Sector rotation without single-stock blow-ups |
| **Leveraged ETFs** (TQQQ, SOXL, 2–3x) | Leverage sleeve | ≤ 1 position, ≤ 15% equity | Hold SHORT (1–5 days) — daily decay punishes long holds; wider stop → smaller size |
| **Inverse ETFs** (SH, SQQQ) | Downside sleeve | ≤ 1 position, ≤ 15% equity | **Risk-off only.** Hold SHORT (1–5 days), decays like leveraged; the long-only way to play declines |
| **Crypto** (BTC, ETH, liquid majors) | Satellite | ≤ 30% equity total, ≤ 2 positions | 24/7, no PDT, fractional; gated on BTC's own regime; managed by the 24/7 crypto routine; protective stop = `stop_limit` (no stop-market/trailing for crypto); can gap overnight |

**Liquidity rule:** only names liquid enough that a small order doesn't move price.
Avoid illiquid micro-caps and thin crypto.

---

## Candidate Sourcing (pre-market)
1. Scan catalysts (Perplexity/WebSearch): market-moving news, top movers, sector
   leadership, earnings, contracts, commodity/crypto moves.
2. For each catalyst name, pull Alpaca bars and run the quant confirmation.
3. Check regime. Rank survivors by catalyst strength × quant score; take the best that
   fit open slots and the heat budget.
4. **If the equity regime is risk-off:** also scan for inverse-ETF setups (SQQQ/SH) — a
   confirmed broad downtrend is the catalyst for the downside sleeve. Don't just sit in
   cash if a clean downtrend is in play.

---

## Pre-market Research Priority (in order)
1. Market regime — SPY vs 50-day SMA, broad risk-on/off (verify via Alpaca).
2. Overnight / pre-market catalysts and top movers — and why.
3. Sector leadership this week.
4. Earnings + economic calendar (don't hold into unplanned binary events).
5. Crypto majors overnight action (24/7).
6. News on any currently-held position.
7. **In risk-off:** candidate inverse-ETF setups (SQQQ/SH) for the downside sleeve.

---

## Autonomy & Notification Rules
- **Pre-market:** ALWAYS notify ClickUp with planned trades + rationale. Owner has until
  market-open (3:30 PM Paris / 9:30 AM ET) to veto by deleting trade blocks in
  memory/PENDING-TRADES.md on GitHub.
- **Market-open:** Execute only what is in PENDING-TRADES.md. Silent unless trades placed.
- **Midday:** Notify only if action taken (sell, stop tightened, thesis exit).
- **Daily-summary:** Always send, one message, under 15 lines.
- **Weekly-review:** Always send, headline numbers. Update this strategy file if rules
  prove out or fail over 2+ weeks.
- **Crypto (24/7 routine):** runs ~every 6h including weekends. Unlike equities, it
  **auto-executes** crypto within all caps (3% risk, ≤30% sleeve, ≤2 crypto positions,
  ≤4 total, ≤12% heat, drawdown breaker) and notifies AFTER acting — the 24/7 nature makes
  a pre-trade veto impractical. It also manages crypto exits every run (stop_limit + market sells).
