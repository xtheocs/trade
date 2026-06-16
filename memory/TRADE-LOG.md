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

### Jun 16 — Market-Open Fill

| Date | Ticker | Sleeve | Shares | Entry | Stop(−2ATR) | Risk/sh | Risk% | Catalyst | R:R |
|------|--------|--------|--------|-------|-------------|---------|-------|----------|-----|
| Jun 16 | SMH | ETF (semis) | 0.417517 | $646.656 | $586.01 | $60.65 | 2.34% | Tech/semi sector leadership, AI-capex theme, risk-on grind to record highs | 2.05:1 |

**Stop blocked — set next run.** GTC stop and GTC trailing_stop both rejected by Alpaca
(`fractional orders must be DAY orders`) — qty 0.417517 is fractional because the 25%-eq
cap ($270) is far below one SMH share (~$647) on this $1,080 account. No DAY-only
workaround placed (would lapse overnight, leaving the position unprotected with no real
benefit). Manage manually: monitor price each routine and exit if it trades through
$586.01, until equity grows enough to size a whole-share stop.
