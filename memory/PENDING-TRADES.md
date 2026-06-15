# Pending Trades

This file is written by the pre-market routine and read by the market-open routine.

## How to veto a trade
Remove the entire trade block before market-open fires (3:30 PM Paris / 9:30 AM ET).
Edit this file directly on GitHub. Market-open will only execute trades still listed here.

---

## Pending Trades — 2026-06-15 (for Mon Jun 15 open)

To veto: delete the trade block below before **3:30 PM Paris / 9:30 AM ET Monday** on GitHub.

---

### TRADE 1 — SMH (VanEck Semiconductor ETF)

| Field | Value |
|-------|-------|
| Action | BUY |
| Shares | 0.44 (fractional; 25% cap binds) |
| Order type | market at open |
| Entry est. | ~$619 (Jun 12 close; actual higher given +1.21% futures) |
| Stop (GTC) | entry − $61.48 (2×ATR14) — place immediately after fill |
| Target | entry + $122.96 (4×ATR14; 2:1 R:R minimum) |
| Position size | ~$272 (≈25% equity) |
| Real risk | ~$27.05 (≈2.5% equity) |
| Catalyst | AI capex → semi leadership; MU +7.58% / STX +6.17% premarket; S&P futures +1.21% |
| Quant | 4/5 (trend✓ momentum✓ rel_strength✓ over-extended✗ volume=pending) |
| Regime | RISK-ON (SPY $741.67 > rising 50d SMA $722.75) |
| Thesis | ETF expression of leading AI/semi theme; avoids single-name FOMC binary risk |

**Execution note:** Confirm volume at open is above 20d avg (427k) before filling. If SMH opens >5% above Jun 12 close ($649+), skip — do not chase extended opens.

---
