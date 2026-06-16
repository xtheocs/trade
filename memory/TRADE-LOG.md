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

### Jun 16 — EOD Snapshot (Day 2)
**Equity:** $1,067.96 | **Cash:** $810.01 (75.89%) | **Day:** -1.11% | **Phase:** -1.11% | **Peak:** $1,080.00 | **DD:** -1.11%

| Ticker | Sleeve | Shares | Entry | Close | Day Chg | Unrealized P&L | Stop |
|--------|--------|--------|-------|-------|---------|----------------|------|
| SMH | Core/Theme (semis ETF) | 0.4175 | $646.66 | $617.77 | -4.53% | -$12.06 (-4.47%) | $586.01 (DAY order, NOT GTC) |

**Notes:** First trade of the phase: bought SMH (semis ETF, AI-capex/sector-leadership theme, 4/5 quant) at $646.66 for ~$270 (25% cap binds), per pre-market research. SMH sold off -4.53% intraday alongside broader market weakness into FOMC/PCE week, position down -4.47% unrealized — within normal volatility, nowhere near the -10% cut-loser threshold. **Flag:** the protective stop on the books is a plain `stop` order with `time_in_force=day` (expires_at 2026-06-16T20:00:00Z), not the real GTC trailing stop the strategy rules require — research log says GTC was intended. As of this snapshot (20:05 UTC) the order still showed status "new" but had passed its stated expiry; status should be re-verified and replaced with a proper GTC trailing stop before the position is held overnight. One trade today, 1/3 used this week (Mon-Tue). No new peak; small drawdown from the $1,080.00 peak.
