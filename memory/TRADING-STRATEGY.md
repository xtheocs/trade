# Trading Strategy

## Mission
Beat the S&P 500 over the challenge window. Stocks only — no options, ever.
Momentum and trend-following approach: ride strong moves, cut fast, follow sectors.

## Capital & Constraints
- Starting capital: ~$100,000
- Platform: Alpaca (paper to start, live when strategy is validated)
- Instruments: Stocks ONLY — no options, ever
- Max positions: 6
- Target deployment: 75-85% of equity (~$75,000–$85,000)

## Core Rules
1. NO OPTIONS — ever
2. 75-85% deployed at all times
3. Maximum 6 positions, max 25% each (~$25,000 per position)
4. 10% trailing stop on every new position as a real GTC order
5. Cut losers at -10% manually, no exceptions
6. Tighten trail: 8% at +15%, 6% at +20%
7. Never tighten within 3% of current price; never move a stop down
8. Max 3 new trades per week
9. Follow sector momentum — only trade sectors in confirmed uptrend
10. Exit a sector after 2 consecutive failed trades
11. Patience > activity. A week with zero trades is fine.

## Trading Style — Momentum / Trend Following
Buy strength, not weakness. Enter on breakouts with volume confirmation.
Every trade must satisfy at least 2 of these 3 filters:

1. **SECTOR ROTATION** — sector must be in confirmed uptrend (leading YTD, recent outperformance vs S&P)
2. **MACRO THEME** — trade aligns with a running macro narrative:
   - AI infrastructure & semiconductors
   - Defence & aerospace spending
   - Energy transition & commodities
   - Reshoring & domestic manufacturing
3. **NEWS CATALYST** — specific event driving the move today:
   earnings beat, contract win, analyst upgrade, regulatory approval, macro data surprise

## Entry Checklist (document before placing any order)
- Which filters apply (need minimum 2)?
- Is the sector in momentum / rotation?
- What is the specific catalyst or macro theme?
- Is the stock breaking out or at a key technical level with volume?
- Stop level (8-10% below entry)
- Target (minimum 2:1 R:R)

## Buy-Side Gate (ALL must pass — if any fail, skip and log the reason)
- Total positions after fill <= 6
- Trades this week (including this one) <= 3
- Position cost <= 25% of equity (~$25,000)
- Position cost <= available cash
- Specific catalyst documented in today's RESEARCH-LOG.md
- Sector is in confirmed uptrend
- Instrument is a stock (not an option)
- Trade is listed in memory/PENDING-TRADES.md (not vetoed by owner)

## Sell-Side Rules (evaluated at midday scan and opportunistically)
- Unrealized loss <= -10%: close immediately, no exceptions
- Thesis broken (catalyst invalidated, sector rolling over, news event): close even if not at -10% yet
- Up +20% or more: cancel trailing stop, place new one at 6%
- Up +15% or more: cancel trailing stop, place new one at 8%
- Sector with 2 consecutive failed trades: exit ALL positions in that sector

## Pre-market Research Priority Order
Run Perplexity queries in this order:
1. S&P 500 sector performance — which sectors are leading/lagging this week?
2. Macro theme momentum — AI, defence, energy, reshoring — any developments?
3. S&P 500 futures and VIX
4. Pre-market earnings beats/misses
5. Economic calendar (CPI, PPI, FOMC, jobs)
6. Oil/commodity prices
7. Breaking news on any currently-held ticker
8. Top pre-market volume movers and why

## Autonomy & Notification Rules
- **Pre-market**: ALWAYS send ClickUp with planned trades + rationale. Owner has until market-open (3:30 PM Paris / 9:30 AM ET) to veto by editing memory/PENDING-TRADES.md on GitHub.
- **Market-open**: Only execute trades still listed in PENDING-TRADES.md. Silent notification.
- **Midday**: Notify only if action taken (sell, stop tightened, thesis exit).
- **Daily-summary**: Always send, one message, under 15 lines.
- **Weekly-review**: Always send, headline numbers only.
