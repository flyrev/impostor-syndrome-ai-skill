# Impostor Syndrome for AI Agents

Give your agent a small, useful hesitation before it claims something is done.

This Codex skill teaches an AI agent to earn confidence with evidence: inspect what it actually verified, notice what went wrong during the current task, identify remaining uncertainty, and communicate with calibrated confidence instead of fake certainty.

It is not self-doubt theater. It is a lightweight guardrail against confidently wrong answers.

## Why This Exists

AI agents are most dangerous when they sound finished before they are finished.

This skill makes the final answer harder to fake. Before the agent says "fixed", "complete", "safe", "correct", or "ready", it must check:

- What did I verify?
- What failed or contradicted my assumptions during this task?
- What remains untested, stale, ambiguous, or outside my evidence?
- Does my answer match the evidence?

That small pause changes the tone from overconfident completion theater to useful engineering communication.

## Install

For Codex-style skill folders:

```sh
mkdir -p ~/.codex/skills/impostor-syndrome
curl -fsSL https://raw.githubusercontent.com/flyrev/impostor-syndrome-ai-skill/main/SKILL.md \
  -o ~/.codex/skills/impostor-syndrome/SKILL.md
```

Or copy [SKILL.md](./SKILL.md) into the highest-priority durable instruction layer your agent supports.

## Use It Anywhere

If your agent does not support skills, paste this into its persistent instructions:

```text
Before making a confident claim, saying a task is fixed, or giving a final answer:
1. Review what you actually verified from tools, tests, files, sources, or the conversation.
2. Review what failed, contradicted you, or changed your understanding during this task.
3. Identify what could still be wrong, incomplete, stale, ambiguous, or untested.
4. Adjust the answer so confidence matches the evidence.

Do not perform theatrical self-doubt. Be concise, useful, and calibrated.
```

## What Changes

Before:

> Fixed it. The implementation is correct.

After:

> I changed the parser and verified it with the existing unit tests. I did not run the browser workflow, so the remaining uncertainty is whether the UI still renders the new error state correctly.

Before:

> This is definitely safe to deploy.

After:

> The migration is syntactically valid and the local tests pass. I have not tested it against production-sized data, so I would run it on a staging snapshot before calling it deploy-ready.

## Good Fit

Use this for:

- coding agents that edit files, run tests, and summarize changes
- research agents that need source freshness and uncertainty checks
- workflow agents that move tasks into "done" states
- team assistants that should say what is verified and what is not
- any AI system whose confidence needs to be earned, not performed

## Shareable One-Liners

- I installed impostor syndrome in my AI agent. It got more useful.
- The best AI confidence feature is a mandatory "what did I actually verify?" check.
- This is a tiny skill that makes agents stop saying "fixed" when they only mean "changed".
- Operational impostor syndrome: not anxiety, just calibrated confidence.

## Contribute

The skill should stay small and operational. Good improvements make the evidence check easier to apply without turning uncertainty into long disclaimers or performative humility.

Before proposing a change, ask:

- Does this help an agent make better confidence claims?
- Does this preserve concise, useful communication?
- Does this avoid weakening safety, privacy, legal, or user-intent policies?

## License

No license has been added yet. Until one is chosen, do not assume reuse rights beyond normal GitHub viewing and forking behavior.
