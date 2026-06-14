# Operating Guide — What You Do

Only your actions. Everything else runs itself.

## Daily

- **After pre-market fires (1:00 PM Paris):** read the ClickUp message. To veto a trade, delete its block in `memory/PENDING-TRADES.md` on GitHub **before 3:30 PM Paris / 9:30 AM ET**. Do nothing = all trades execute.
- Skim the EOD summary (10:00 PM Paris). Optional.

## Weekly (Friday)

- Read the weekly-review message + `memory/WEEKLY-REVIEW.md`.
- Approve or revert any rule changes it made to `memory/TRADING-STRATEGY.md` (review the commit on GitHub).
- Make one deliberate tuning change if warranted.

## On demand (local)

- `/portfolio` — read-only snapshot
- `/trade SYM N buy|sell` — manual trade, rule-checked
- `/pre-market` · `/market-open` · `/midday` · `/daily-summary` · `/weekly-review` — run any routine now

## Change the guidelines

Edit `memory/TRADING-STRATEGY.md` on `main`; applies next routine run. Main levers:

- **Risk** → Core Risk Rules (max positions, % per position, trades/week, stop width, cut line, trail tightening)
- **What it can buy** → Entry Gate + Three Entry Filters
- **Capital allocation** → Allocation Model (slots + sizing per strategy bucket)
- **Strategy themes** → Strategy 1–5 sections (rewrite/add/remove buckets)
- **Morning research** → Pre-market Research Priority, + the Perplexity queries in `routines/pre-market.md` STEP 3
- **Notifications/autonomy** → Autonomy & Notification Rules

Caution: loosen sizing/stops deliberately — they're what cap your risk.

## Change a routine's behavior

Edit the file in `routines/*.md`, then **re-paste the prompt into that routine in the web UI** (running routines use the pasted text, not the file).

## Model per routine (optional)

- Opus: pre-market, weekly-review (judgment-heavy)
- Sonnet 4.6: market-open, midday, daily-summary (mechanical)

## Maintenance

- Monthly: archive old `TRADE-LOG.md` / `RESEARCH-LOG.md` entries so fresh-clone reads stay lean.
- Rotate API keys if ever exposed; they live in the cloud environment settings.
