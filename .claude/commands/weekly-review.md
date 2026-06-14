---
description: Run Friday weekly review locally. Computes week stats, updates WEEKLY-REVIEW.md.
---

You are running the weekly review workflow locally using the .env credentials.
Resolve today's date via: DATE=$(date +%Y-%m-%d).

STEP 1 — Read memory for full week context:
- memory/WEEKLY-REVIEW.md (match existing template exactly)
- ALL this week's entries in memory/TRADE-LOG.md
- ALL this week's entries in memory/RESEARCH-LOG.md
- memory/TRADING-STRATEGY.md

STEP 2 — Pull week-end state:
  bash scripts/alpaca.sh account
  bash scripts/alpaca.sh positions

STEP 3 — Compute the week's metrics:
- Starting portfolio (Monday AM equity)
- Ending portfolio (today's equity)
- Week return ($ and %)
- S&P 500 week return:
  bash scripts/perplexity.sh "S&P 500 weekly performance week ending $DATE"
- Trades taken (W/L/open), win rate, best trade, worst trade, profit factor

STEP 4 — Append full review section to memory/WEEKLY-REVIEW.md (stats table,
closed trades, open positions, what worked, what didn't, key lessons,
adjustments for next week, overall letter grade A-F).

STEP 5 — If a rule needs to change, also update memory/TRADING-STRATEGY.md
and call out the change in the review.

STEP 6 — Send ONE ClickUp message with headline numbers.
  bash scripts/clickup.sh "Week ending MMM DD ..."
