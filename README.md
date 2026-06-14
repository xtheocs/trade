# AI Trading Bot

Autonomous swing-trading agent built on Claude Code cloud routines.

## Stack

| Component | Role |
|-----------|------|
| Claude Code cloud routines | Scheduler / executor |
| Alpaca (paper) | Trade execution |
| Perplexity API | Market research |
| ClickUp Chat | Notifications |
| GitHub (this repo) | Persistent memory |

## Local Smoke Test

```bash
# 1. Copy and fill in credentials
cp env.template .env
# Edit .env with your Alpaca paper API keys, Perplexity key, ClickUp IDs

# 2. Open in Claude Code, then run:
/portfolio
# Should print a clean account snapshot
```

## Five Daily Workflows (Europe/Paris)

| Workflow | Paris time | ET time |
|----------|-----------|---------|
| Pre-market research | 1:00 PM | 7:00 AM |
| Market-open execution | 3:30 PM | 9:30 AM |
| Midday scan | 7:00 PM | 1:00 PM |
| Daily summary | 10:00 PM | 4:00 PM |
| Weekly review (Fri) | 11:00 PM | 5:00 PM |

## Ad-hoc Commands (local only)

- `/portfolio` — read-only snapshot, no trades
- `/trade SYMBOL SHARES buy|sell` — manual trade with rule validation

## Cloud Routine Setup (one-time)

See `routines/README.md` for step-by-step instructions.

## Security Rules

- `.env` is gitignored — never commit it
- Cloud routines receive credentials as env vars, never via files
- Never share API keys in any file, log, or notification message
