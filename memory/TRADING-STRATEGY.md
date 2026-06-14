# Trading Strategy

## Mission
Beat the S&P 500 over the challenge window. Stocks only — no options, ever.
Style: momentum / trend following. Buy strength, follow sectors, ride macro themes.
This file is updated by the weekly review if rules prove out or fail over 2+ weeks.

## Capital & Constraints
- Starting capital: ~$100,000 (paper to start)
- Platform: Alpaca
- Instruments: Stocks ONLY — no options, ever
- Max positions: 6
- Target deployment: 75-85% of equity (~$75,000–$85,000)

---

## Core Risk Rules (non-negotiable)
1. NO OPTIONS — ever
2. Maximum 6 open positions
3. Maximum 25% per position (~$25,000), except health/biotech: max $12,500
4. Maximum 3 new trades per week
5. 10% trailing stop on every new position as a real GTC order — placed immediately after fill
6. Cut losers at -10% manually, no exceptions, no hoping
7. Tighten trailing stop: 8% when position up +15%, 6% when up +20%
8. Never tighten within 3% of current price. Never move a stop down.
9. Exit a sector after 2 consecutive failed trades in that sector
10. Patience > activity. Zero trades in a week can be the right answer.
11. Time stop: if a position hasn't moved significantly after 10 trading days → close to free capacity

---

## Entry Gate (ALL must pass before placing any buy order)
- Total positions after fill <= 6
- Trades this week (including this one) <= 3
- Position cost <= 25% of equity ($25,000 max; $12,500 for biotech)
- Position cost <= available cash
- Specific catalyst documented in today's RESEARCH-LOG
- Instrument is a stock (not an option)
- Sector is in confirmed uptrend per today's research
- Trade must satisfy at least 2 of the 3 entry filters below
- Trade is listed in memory/PENDING-TRADES.md (owner has not vetoed it)

---

## Three Entry Filters (minimum 2 must apply to every trade)

**FILTER 1 — SECTOR ROTATION**
The sector must be in confirmed uptrend: leading YTD, recent outperformance vs S&P,
positive rating in current Schwab/State Street sector research.
Avoid: consumer discretionary, real estate (soft revenue/FCF trends in 2025/2026).
Currently favoured: technology, industrials, energy, materials, health care.

**FILTER 2 — MACRO THEME**
Trade must align with at least one running macro narrative:
- AI infrastructure: semiconductor equipment, data-center buildout, memory/optical fiber demand
- Defence spending: US defence budget +15% FY2026 (OBBBA), shipbuilding, missiles, cybersecurity
- Energy transition & security: renewables, grid infrastructure, copper/lithium miners
- Reshoring & manufacturing: domestic fabs, industrial automation, materials for new plants

**FILTER 3 — NEWS CATALYST**
A specific event is driving the move today:
earnings beat, contract win, analyst upgrade, FDA approval, partnership announcement,
commodity price surge, legislation passed.
Headlines mentioning "beats by", "revenue up X%", "raises guidance", "awarded $X contract",
"new 52-week high", "surges X% on heavy volume" all count.

---

## Sell-Side Rules (evaluated at midday scan and opportunistically)
- Unrealized loss <= -10%: close immediately, no exceptions
- Thesis broken: close even if not at -10% (catalyst invalidated, sector rolling over, bad news)
- Up +20% or more: cancel stop, place new trailing stop at 6%
- Up +15% or more: cancel stop, place new trailing stop at 8%
- 2 consecutive failed trades in a sector: exit ALL positions in that sector
- Time stop: close if no meaningful movement after 10 trading days

---

## Strategy Allocation Model (how to fill 6 positions)

| Strategy | Max slots | Position size | Current macro tailwind |
|----------|-----------|--------------|----------------------|
| AI Infrastructure | 2 | $25,000 each | Semiconductor capex +37% earnings growth 2026 |
| Defense & Reshoring | 2 | $25,000 each | US defence budget >$1T, +15% FY2026 |
| Energy & Materials | 1 | $25,000 | Supply disruptions, commodity demand from AI+EVs |
| Health/Biotech | 1 | $12,500 ONLY | FDA approvals, GLP-1, genomics — binary risk |
| FinTech/Digital | 1 | $25,000 | Only if compelling catalyst; sector is neutral |

Never put more than 2 positions in any single strategy bucket.

---

## Strategy 1 — AI Infrastructure Momentum

**Candidate signals (Perplexity research each morning):**
- "record sales", "orders surge", "beats earnings", "new data-center contract", "launches AI chip"
- Semiconductor manufacturers, memory suppliers, cloud infrastructure, optical fiber, power semis
- Analyst upgrades tied to AI capex or data-center demand
- Headlines: "new 52-week high", "surges X% on heavy volume"

**Entry:** Catalyst + price momentum (>5% daily move OR near 52-week high) + sector tailwind confirmed
**Profit target:** 20-30% gain, or if news suggests overheating/overvaluation
**Exit early:** No positive news for >3 consecutive days; momentum fades; downgrade or guidance cut
**Avoid:** Mega-cap AI names with stretched valuations — too crowded

---

## Strategy 2 — Defense & Reshoring Momentum

**Candidate signals:**
- "awarded $X billion contract", "Congress approves appropriation", "backlog grows"
- Prime contractors, missile/shipbuilding suppliers, cybersecurity for military, industrial automation
- Reshoring: new domestic manufacturing facilities, government incentives, supply-chain partnerships
- Industrials sector favoured by Schwab due to AI infrastructure + defence + energy spending

**Entry:** Contract/funding catalyst + price momentum (>4% daily move OR near 52-week high) + sector positive
**Profit target:** 15-25% (defence stocks less volatile than tech)
**Exit early:** Legislation stalls, contract cancelled, peace reducing defence budgets
**Time stop:** 3 weeks if thesis hasn't played out

---

## Strategy 3 — Energy & Materials Momentum

**Candidate signals:**
- "oil surges on supply concerns", "copper prices hit two-year high", "OPEC cut"
- Low-cost oil/gas producers, renewable developers with government contracts
- Copper/lithium miners (AI datacenters + EV demand), industrial metals
- State Street upgraded Energy and Materials to positive (supply disruption risk + structural demand)

**Entry:** Commodity price catalyst or earnings beat + momentum + policy support
**Profit target:** 20% energy, 25% volatile mining stocks
**Exit early:** Geopolitical tensions ease (oil reversal), Schwab/State Street downgrade sector
**Sizing note:** Commodity-sensitive small caps → half-size ($12,500)

---

## Strategy 4 — Health/Biotech Catalysts (limited, $12,500 only)

**Candidate signals:**
- FDA approval, breakthrough designation, positive Phase-III data
- GLP-1 weight-loss drugs, CRISPR/gene-editing, AI diagnostics, telehealth
- Partnership/acquisition announcements at premium; medical device regulatory approvals

**Entry:** Confirmed regulatory catalyst (NOT ahead of unconfirmed trial readouts)
  Stock must jump >7% on news before considering entry
**Profit target:** 30-40% (high volatility, explosive moves)
**Exit immediately:** Negative trial outcome or regulatory setback
**Max size:** $12,500 ALWAYS — binary risk, never full position

---

## Strategy 5 — FinTech/Digital Transformation (only when compelling)

**Candidate signals:**
- Double-digit revenue/user growth, profitability improvement, major bank partnership
- Mobile payments, digital settlement, AI personal finance, blockchain infrastructure
- Regulatory modernization enabling new products

**Entry:** Strong earnings + partnership catalyst + >5% move + reasonable valuation
**Profit target:** 15-20% (competition and regulatory risk)
**Exit early:** Adverse policy, security breach, momentum fades
**Note:** Financials are NEUTRAL rated — only allocate when catalyst is exceptional

---

## Momentum Proxy Rules (since bot cannot compute technical indicators)

Use these news-based proxies instead of indicators:
- **52-week high:** Look for headlines "new 52-week high", "all-time high", "multi-year high"
- **Volume surge:** Headlines mentioning "on heavy volume", "volume X times average"
- **Daily move:** Stock must move >4-5% on news day (mentioned in articles or in Alpaca quote vs prior close)
- **No positive news >3 days:** Momentum has faded — prepare to exit

---

## Pre-market Research Priority (in order)

1. Which S&P 500 sectors are leading/lagging this week? (sector rotation check)
2. Macro theme updates: AI capex, defence spending, commodity moves, reshoring news
3. S&P 500 futures direction and VIX level
4. Earnings beats/misses today before open
5. Economic calendar (CPI, PPI, FOMC, jobs)
6. WTI/Brent oil and key commodity prices
7. Top pre-market volume movers and why (momentum proxy)
8. Breaking news on any currently-held ticker

---

## Autonomy & Notification Rules

- **Pre-market:** ALWAYS notify ClickUp with planned trades + rationale. Owner has until market-open (3:30 PM Paris / 9:30 AM ET) to veto by deleting trade blocks in memory/PENDING-TRADES.md on GitHub.
- **Market-open:** Execute only what is in PENDING-TRADES.md. Silent unless trades placed.
- **Midday:** Notify only if action taken (sell, stop tightened, thesis exit).
- **Daily-summary:** Always send, one message, under 15 lines.
- **Weekly-review:** Always send, headline numbers. Update this strategy file if rules prove out or fail over 2+ weeks.
