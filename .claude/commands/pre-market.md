---
description: Run pre-market research locally. Reads strategy, queries Perplexity per strategy bucket, writes RESEARCH-LOG and PENDING-TRADES.
---

You are running the pre-market research workflow locally using the .env credentials.
Resolve today's date via: DATE=$(date +%Y-%m-%d).

STEP 1 — Read memory:
- memory/TRADING-STRATEGY.md (full strategy, all 5 frameworks, entry filters, allocation model)
- tail of memory/TRADE-LOG.md (open positions, weekly trade count)
- tail of memory/RESEARCH-LOG.md

STEP 2 — Pull live account state:
  bash scripts/alpaca.sh account
  bash scripts/alpaca.sh positions
  bash scripts/alpaca.sh orders

STEP 3 — Run Perplexity research by strategy bucket:

MACRO & SECTOR:
- "S&P 500 sector performance this week — which sectors are leading and lagging YTD and this week?"
- "S&P 500 futures premarket today and VIX level $DATE"
- "Economic calendar today $DATE — CPI PPI FOMC jobs data any major releases"

AI INFRASTRUCTURE:
- "AI semiconductor data-center earnings announcements and news today $DATE"
- "Semiconductor equipment optical fiber memory stocks news today $DATE"

DEFENSE & RESHORING:
- "US defense contracts awarded announcements today $DATE"
- "Industrial reshoring manufacturing automation news today $DATE"

ENERGY & MATERIALS:
- "WTI Brent oil price and commodity moves copper lithium gold $DATE"
- "Energy materials stocks earnings supply disruptions news today $DATE"

HEALTH/BIOTECH (if slot available):
- "FDA approvals biotech earnings drug trial results today $DATE"

HELD POSITIONS:
- "[TICKER] news today $DATE" for each open position

TOP MOVERS:
- "Top premarket stock movers today by volume what stocks are surging and why $DATE"

STEP 4 — Write dated entry to memory/RESEARCH-LOG.md with:
candidates by strategy bucket, sector rotation summary, market context,
held position updates, risk factors, decision (TRADE or HOLD).

STEP 5 — Write memory/PENDING-TRADES.md with planned trades (or no-trade note).

STEP 6 — ALWAYS notify ClickUp. MOBILE layout: each field on its own short line, bold the
title/section/ticker lines, "·" as the in-line separator, NO emojis, NO 4-space indents.
Date as DD-MM-YYYY. Tag the instrument type after the ticker: (stock) (ETF) (leveraged ETF)
(inverse ETF). $[amount] = dollars in the position; $[price] = per-share price.
Every number comes from Alpaca (account + quant.sh), never from Perplexity. Include a macro
line (Oil/VIX/futures) ONLY when notably moving or relevant to a planned trade — otherwise
omit it. The "Why" must be plain English. If trades are planned:
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
