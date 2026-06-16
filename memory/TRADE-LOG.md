# Trade Log

## Day 0 — EOD Snapshot (pre-launch baseline)
**Equity:** $1,080.00 | **Cash:** $1,080.00 (100%) | **Day P&L:** $0 | **Phase P&L:** $0 | **Peak:** $1,080.00

No positions yet. Paper test starting balance: **$1,080** (≈ 1,000 €). Phase P&L and
drawdown are measured from here.

---

### Jun 15 — EOD Snapshot (Day 1)
**Equity:** $1,080.00 | **Cash:** $1,080.00 (100%) | **Day:** +0.00% | **Phase:** +0.00% | **Peak:** $1,080.00 | **DD:** 0.00%

| Ticker | Sleeve | Shares | Entry | Close | Day Chg | Unrealized P&L | Stop |
|--------|--------|--------|-------|-------|---------|----------------|------|
| — | — | — | — | — | — | — | — |

**Notes:** First live trading day of the phase. No trades executed; account sits fully in cash at $1,080.00. Equity is unchanged from the Day 0 baseline — phase P&L and drawdown both at zero. No open positions or pending orders. Account is active and ready to deploy capital once pre-market research identifies qualifying momentum setups meeting the 2-of-3 catalyst requirement.

---

### Jun 16 — Midday Scan (Day 2)

**Backfill — SMH entry never logged at market-open (TRADE-LOG had no record; only fill found in order history):**

| Date | Ticker | Sleeve | Shares | Entry | Stop (−2ATR) | Risk/sh | Risk% | Catalyst | R:R |
|------|--------|--------|--------|-------|---------------|---------|-------|----------|-----|
| Jun 16 | SMH | ETF | 0.417517 | $646.656 | $586.01 | $60.65 | 2.36% | Tech/semi sector leadership, AI-capex theme, broad risk-on | 2:1 |

**Action taken:** No live stop existed on SMH — market-open filled the buy (market order, notional $270) but never placed the protective stop; order history shows only the single buy fill, no stop attempt. Placed sell-stop now at **$586.01** (entry − 2×ATR₁₄, ATR₁₄=$30.75).

**Known issue — fractional qty blocks GTC stops:** Alpaca rejects GTC stop orders on fractional share quantities (`fractional orders must be DAY orders`, error 42210000). Because SMH was sized via `notional` (→ fractional qty 0.4175 sh), only a **DAY** stop order is possible, not GTC as the strategy calls for. Placed DAY stop @ $586.01 — expires at today's close (20:00 UTC) and must be re-checked/re-placed every session until the position closes. Flag for strategy/process fix: either size new positions to whole shares when the dollar amount allows whole-share sizing, or every routine touching open positions must verify and re-place the day-stop each session.

**Status:** price $628.17 vs stop $586.01 — no hard exit. Regime risk-on (SPY 752.48 > rising 50d SMA). No thesis break, no catalyst invalidation. Held 0 trading days — no time stop. Position currently −2.86% (below entry, hasn't moved up 1×ATR) — no winner-management trigger. No other action taken.

**Equity:** $1,072.37 | **Peak:** $1,080.00 | **DD:** 0.71% (breaker inactive, threshold 20%)
