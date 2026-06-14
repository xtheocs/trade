#!/usr/bin/env bash
# Quant confirmation helper — computes the §5 entry checks and market regime from
# ALPACA price bars only (never from Perplexity numbers).
#
# Usage:
#   bash scripts/quant.sh signal SYM           # stock/ETF: 5 checks vs SPY + ATR stop
#   bash scripts/quant.sh signal BTC/USD crypto# crypto: checks vs BTC
#   bash scripts/quant.sh regime               # SPY -> risk_on / neutral / risk_off
#   bash scripts/quant.sh regime crypto        # BTC -> risk_on / neutral / risk_off
#
# Output is JSON. "confirmed": true means >=3 of 5 checks passed.

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ALP="bash $ROOT/scripts/alpaca.sh"

fetch_bars() { # $1=symbol  $2=stock|crypto
  if [[ "${2:-stock}" == crypto ]]; then $ALP crypto-bars "$1" 200; else $ALP bars "$1" 200; fi
}

mode="${1:?usage: signal SYM [crypto] | regime [crypto]}"; shift || true

case "$mode" in
  signal)
    sym="${1:?usage: signal SYM [crypto]}"; kind="${2:-stock}"
    if [[ "$kind" == crypto ]]; then bench="BTC/USD"; bkind="crypto"; else bench="SPY"; bkind="stock"; fi
    sym_json="$(fetch_bars "$sym" "$kind")"
    bench_json="$(fetch_bars "$bench" "$bkind")"
    python3 - "$sym" "$kind" "$sym_json" "$bench_json" <<'PY'
import json, sys
sym, kind, sym_raw, bench_raw = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
def bars(raw, symbol):
    d = json.loads(raw); b = d.get("bars")
    if isinstance(b, dict):
        b = b.get(symbol) or (next(iter(b.values()), []) if b else [])
    return b or []
sb = bars(sym_raw, sym)
bb = bars(bench_raw, "BTC/USD" if kind == "crypto" else "SPY")
if len(sb) < 55:
    print(json.dumps({"symbol": sym, "error": "insufficient bars", "n": len(sb)})); sys.exit(0)
c = [x["c"] for x in sb]; h = [x["h"] for x in sb]; l = [x["l"] for x in sb]; v = [x["v"] for x in sb]
def sma(a, n): return sum(a[-n:]) / n
last = c[-1]
sma20, sma20p = sma(c, 20), sma(c[:-1], 20)
hi20 = max(h[-20:])
ret10 = last / c[-11] - 1
trs = [max(h[i]-l[i], abs(h[i]-c[i-1]), abs(l[i]-c[i-1])) for i in range(1, len(sb))]
atr = sum(trs[-14:]) / 14
avgvol = sum(v[-20:]) / 20
brc = [x["c"] for x in bb]
bret10 = (brc[-1] / brc[-11] - 1) if len(brc) > 11 else 0.0
checks = {
    "trend": last > sma20 and sma20 > sma20p,
    "momentum": ret10 > 0 and last >= 0.95 * hi20,
    "rel_strength": ret10 > bret10,
    "volume": v[-1] > avgvol,
    "not_extended": ((last - sma20) / atr <= 2) if atr > 0 else False,
}
passes = sum(1 for x in checks.values() if x)
out = {
    "symbol": sym, "kind": kind, "last": round(last, 4),
    "sma20": round(sma20, 4), "sma20_rising": sma20 > sma20p,
    "ret_10d": round(ret10, 4), "hi_20d": round(hi20, 4),
    "atr_14": round(atr, 4), "vol_ratio": round(v[-1] / avgvol, 2) if avgvol else None,
    "rs_vs_bench": round(ret10 - bret10, 4),
    "checks": checks, "passes": passes,
    "suggested_stop": round(last - 2 * atr, 4), "risk_per_share": round(2 * atr, 4),
    "confirmed": passes >= 3,
}
print(json.dumps(out, indent=2))
PY
    ;;
  regime)
    kind="${1:-stock}"
    if [[ "$kind" == crypto ]]; then sym="BTC/USD"; else sym="SPY"; kind="stock"; fi
    j="$(fetch_bars "$sym" "$kind")"
    python3 - "$sym" "$j" <<'PY'
import json, sys
sym, raw = sys.argv[1], sys.argv[2]
d = json.loads(raw); b = d.get("bars")
if isinstance(b, dict):
    b = b.get(sym) or (next(iter(b.values()), []) if b else [])
c = [x["c"] for x in (b or [])]
if len(c) < 55:
    print(json.dumps({"symbol": sym, "error": "insufficient bars", "n": len(c)})); sys.exit(0)
last = c[-1]; sma50 = sum(c[-50:]) / 50; sma50p = sum(c[-51:-1]) / 50
rising = sma50 >= sma50p
if last > sma50 and rising: r = "risk_on"
elif last < sma50 and not rising: r = "risk_off"
else: r = "neutral"
print(json.dumps({"symbol": sym, "last": round(last, 4), "sma50": round(sma50, 4),
                  "sma50_rising": rising, "regime": r}, indent=2))
PY
    ;;
  *)
    echo "usage: quant.sh signal SYM [crypto] | regime [crypto]" >&2; exit 1 ;;
esac
