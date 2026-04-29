# Impostor Syndrome for AI Agents

> I gave my AI agent impostor syndrome so it stops saying "fixed" before it has verified anything.

This is a tiny Agent Skill that makes coding and research agents more calibrated before they claim something is **done**, **fixed**, **safe**, **correct**, or **certain**.

It tells the agent to check:

- what it actually verified
- what it already got wrong in the current task
- what remains uncertain
- whether its confidence is earned by evidence

It is not about making the agent anxious or verbose. It is about making it honest.

## Why This Exists

AI agents are often too confident at exactly the wrong moment:

> Fixed.
> The tests pass.
> This should work.
> No issues found.

Sometimes that is true. Sometimes no test was run, no file was inspected, and no source was checked.

This skill nudges the agent to say what it knows, what it checked, and what remains unverified.

## Install

### Codex

```sh
gh skill install flyrev/impostor-syndrome-ai-skill flyrev/impostor-syndrome --agent codex --scope user
```

### Claude Code

```sh
gh skill install flyrev/impostor-syndrome-ai-skill flyrev/impostor-syndrome --agent claude-code --scope user
```

### Manual Install

Copy [skills/flyrev/impostor-syndrome/SKILL.md](./skills/flyrev/impostor-syndrome/SKILL.md) into your agent's skills directory.

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

> Fixed. This should work now.

Follow-up:

> Did you run the tests?

Before:

> No.

After:

> I changed the validation path and inspected the relevant function. I have not run the test suite, so I should not claim this is fixed yet. The next verification step is `npm test -- validation.test.ts`.

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

## Publishing

This repository is packaged for GitHub's Agent Skill tooling at:

```text
skills/flyrev/impostor-syndrome/SKILL.md
```

Validate before publishing a release:

```sh
gh skill publish --dry-run
```

## Shareable One-Liners

- I gave my AI agent impostor syndrome so it stops saying "fixed" before it has verified anything.
- New rule: AI agents should not be allowed to say "fixed" unless they can name the test, command, source, or file that proved it.
- AI agents need less "CEO energy" and more "junior engineer who actually ran the tests" energy.
- Operational impostor syndrome: not anxiety, just calibrated confidence.
- Star this if your AI agent has ever lied to you confidently.

## Maintainer Automation

[scripts/](./scripts) contains maintainer-only automation for this repository. It is not part of installing or using the skill.

## Contribute

The skill should stay small and operational. Good improvements make the evidence check easier to apply without turning uncertainty into long disclaimers or performative humility.

Before proposing a change, ask:

- Does this help an agent make better confidence claims?
- Does this preserve concise, useful communication?
- Does this avoid weakening safety, privacy, legal, or user-intent policies?

## License

No license has been added yet. Until one is chosen, do not assume reuse rights beyond normal GitHub viewing and forking behavior.
