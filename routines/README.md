# Cloud Routines Setup

Each file in this directory is pasted verbatim into a Claude Code cloud routine.

## One-time prerequisites

1. **Install the Claude GitHub App** on this repo (least-privilege access).
2. In each routine's environment settings, toggle **"Allow unrestricted branch pushes"** ON.
   This is the #1 reason first-time setups break — git push silently fails without it.
3. Set environment variables on each routine (NOT in any .env file):
   - ALPACA_API_KEY
   - ALPACA_SECRET_KEY
   - ALPACA_ENDPOINT  (= https://paper-api.alpaca.markets/v2)
   - ALPACA_DATA_ENDPOINT  (= https://data.alpaca.markets/v2)
   - PERPLEXITY_API_KEY
   - PERPLEXITY_MODEL  (= sonar)
   - CLICKUP_API_KEY
   - CLICKUP_WORKSPACE_ID
   - CLICKUP_CHANNEL_ID

## Creating each routine (repeat for all 5)

1. Claude Code cloud → Routines → New Routine
2. Name: e.g. "Trading bot pre-market"
3. Repository: this repo, branch: main
4. Add all env vars above
5. Toggle "Allow unrestricted branch pushes" ON
6. Set cron schedule + timezone **Europe/Paris**:

| Routine file | Cron (Europe/Paris) | ET equivalent |
|---|---|---|
| pre-market.md | `0 13 * * 1-5` | 7:00 AM ET |
| market-open.md | `30 15 * * 1-5` | 9:30 AM ET |
| midday.md | `0 19 * * 1-5` | 1:00 PM ET |
| daily-summary.md | `0 22 * * 1-5` | 4:00 PM ET |
| weekly-review.md | `0 23 * * 5` | 5:00 PM ET (Fridays) |

7. Paste the prompt from the corresponding .md file (everything below the cron comment)
8. Save → click **"Run now"** to test. Do not wait until tomorrow.

## Verification

After a successful test run, `git log origin/main` should show a new commit from the agent.
