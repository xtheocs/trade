---
description: Run market-open execution locally. Validates gates and places approved trades.
---

You are running the market-open execution workflow locally using the .env credentials.
Resolve today's date via: DATE=$(date +%Y-%m-%d).

STEP 1 — Read memory for today's plan:
- memory/TRADING-STRATEGY.md
- TODAY's entry in memory/RESEARCH-LOG.md (if missing, run pre-market
  STEPS 1-3 inline — never trade without documented research)
- tail of memory/TRADE-LOG.md (for weekly trade count)

STEP 2 — Re-validate with live data:
  bash scripts/alpaca.sh account
  bash scripts/alpaca.sh positions
  bash scripts/alpaca.sh quote <each planned ticker>

STEP 3 — Hard-check rules BEFORE every order. Skip any trade that fails
and log the reason:
- Total positions after trade <= 6
- Trades this week <= 3
- Position cost <= 20% of equity (~$20,000)
- Catalyst documented in today's RESEARCH-LOG
- daytrade_count leaves room (PDT: 3/5 rolling business days)

STEP 4 — Execute the buys (market orders, day TIF):
  bash scripts/alpaca.sh order '{"symbol":"SYM","qty":"N","side":"buy","type":"market","time_in_force":"day"}'
Wait for fill confirmation before placing the stop.

STEP 5 — Immediately place 10% trailing stop GTC for each new position:
  bash scripts/alpaca.sh order '{"symbol":"SYM","qty":"N","side":"sell","type":"trailing_stop","trail_percent":"10","time_in_force":"gtc"}'
If Alpaca rejects with PDT error, fall back to fixed stop. If also blocked,
queue in TRADE-LOG as "PDT-blocked, set tomorrow AM".

STEP 6 — Append each trade to memory/TRADE-LOG.md.
STEP 7 — Notification: only if a trade was placed.
  bash scripts/clickup.sh "<tickers, shares, fill prices, one-line why>"
