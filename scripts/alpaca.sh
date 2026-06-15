#!/usr/bin/env bash
# Alpaca API wrapper. All trading API calls go through here.
# Usage: bash scripts/alpaca.sh <subcommand> [args...]

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/.env"

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

: "${ALPACA_API_KEY:?ALPACA_API_KEY not set in environment}"
: "${ALPACA_SECRET_KEY:?ALPACA_SECRET_KEY not set in environment}"

API="${ALPACA_ENDPOINT:-https://paper-api.alpaca.markets/v2}"
DATA="${ALPACA_DATA_ENDPOINT:-https://data.alpaca.markets/v2}"

H_KEY="APCA-API-KEY-ID: $ALPACA_API_KEY"
H_SEC="APCA-API-SECRET-KEY: $ALPACA_SECRET_KEY"

# Alpaca returns bars oldest-first and `limit` keeps the FIRST N in the window,
# so a wide `start` + `limit` yields stale bars (the rest hide behind a page
# token). We fetch sort=desc (newest first) to get the latest N, then reverse
# back to ascending so consumers can treat the LAST element as "most recent".
reverse_bars() {
  python3 -c '
import sys, json
d = json.load(sys.stdin)
b = d.get("bars")
if isinstance(b, list):
    d["bars"] = list(reversed(b))
elif isinstance(b, dict):
    d["bars"] = {k: list(reversed(v)) for k, v in b.items()}
json.dump(d, sys.stdout)
'
}

cmd="${1:-}"
shift || true

case "$cmd" in
  account)
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/account"
    ;;
  positions)
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/positions"
    ;;
  position)
    sym="${1:?usage: position SYM}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/positions/$sym"
    ;;
  quote)
    sym="${1:?usage: quote SYM}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$DATA/stocks/$sym/quotes/latest"
    ;;
  orders)
    status="${1:-open}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/orders?status=$status"
    ;;
  order)
    body="${1:?usage: order '<json>'}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" -H "Content-Type: application/json" \
      -X POST -d "$body" "$API/orders"
    ;;
  cancel)
    oid="${1:?usage: cancel ORDER_ID}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/orders/$oid"
    ;;
  cancel-all)
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/orders"
    ;;
  close)
    sym="${1:?usage: close SYM}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/positions/$sym"
    ;;
  close-all)
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/positions"
    ;;
  bars)
    sym="${1:?usage: bars SYM [days]}"
    days="${2:-120}"
    start="$(python3 -c "import datetime; print((datetime.date.today()-datetime.timedelta(days=$days*2+40)).isoformat())")"
    curl -fsS -H "$H_KEY" -H "$H_SEC" \
      "$DATA/stocks/$sym/bars?timeframe=1Day&limit=$days&feed=iex&adjustment=split&sort=desc&start=$start" \
      | reverse_bars
    ;;
  crypto-bars)
    sym="${1:?usage: crypto-bars SYM (e.g. BTC/USD) [days]}"
    days="${2:-120}"
    start="$(python3 -c "import datetime; print((datetime.date.today()-datetime.timedelta(days=$days*2+40)).isoformat())")"
    curl -fsS -H "$H_KEY" -H "$H_SEC" \
      "https://data.alpaca.markets/v1beta3/crypto/us/bars?symbols=$sym&timeframe=1Day&limit=$days&sort=desc&start=$start" \
      | reverse_bars
    ;;
  crypto-quote)
    sym="${1:?usage: crypto-quote SYM (e.g. BTC/USD)}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" \
      "https://data.alpaca.markets/v1beta3/crypto/us/latest/quotes?symbols=$sym"
    ;;
  *)
    echo "Usage: bash scripts/alpaca.sh <account|positions|position|quote|orders|order|cancel|cancel-all|close|close-all|bars|crypto-bars|crypto-quote> [args]" >&2
    exit 1
    ;;
esac

echo
