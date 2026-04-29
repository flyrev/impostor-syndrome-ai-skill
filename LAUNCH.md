# Launch Kit

This repo has a memorable hook:

> I gave my AI agent impostor syndrome so it stops saying "fixed" before it has verified anything.

The launch should use the joke first, then prove the utility in under ten seconds.

## Positioning

One-sentence pitch:

> A tiny Codex skill that makes AI agents check what they actually verified before saying something is fixed, correct, safe, or done.

Core message:

- The problem is not uncertainty. The problem is fake certainty.
- The fix is not verbose disclaimers. The fix is evidence-matched confidence.
- The call to action is installation first, stars second.
- The skill is small enough to read, install, adapt once licensed, and argue with.

Best audiences:

- engineers using coding agents
- AI agent builders
- prompt engineers
- people annoyed by "done" summaries that do not say what was tested
- AI safety and evals people who like practical controls

## GitHub Setup

Do these before posting widely:

- Add repo description: `Make AI agents check what they actually verified before claiming something is done.`
- Add topics: `agent-skills`, `ai-agents`, `codex`, `claude-code`, `prompt-engineering`, `developer-tools`, `llm`, `ai-safety`, `uncertainty`, `verification`
- Confirm GitHub detects the included MIT license.
- Add a social preview image in GitHub settings. GitHub recommends a PNG, JPG, or GIF under 1 MB, with 1280x640 pixels best for display.
- Pin the repo on the owner profile during launch week.
- Run `gh skill publish --dry-run` before creating a release.

Social preview image concept:

```text
Dark editor window with a final-answer checklist:

Impostor Syndrome for AI Agents

[x] What did I verify?
[x] What changed my mind?
[x] What remains uncertain?
[x] Does confidence match evidence?

Tiny footer: not self-doubt, calibrated confidence
```

## Launch Sequence

Day 0:

- Make sure `gh skill publish --dry-run` passes.
- Make sure README installation works from a clean machine or fresh user scope.
- Set the GitHub description, topics, and social preview.
- Prepare a short demo screenshot or 20-second screen recording showing a "before" answer and an "after" answer.

Day 1:

- Post the repo link with the strongest one-liner.
- Ask a concrete question that invites replies: "What confidence check should every coding agent have?"
- Reply to early comments with examples, not abstractions.
- Submit to one developer community where practical AI agent tooling is on topic.

Day 2:

- Post a short follow-up showing one real transcript where the skill changed a final answer.
- Add any good community phrasing back into README examples.
- Open one issue titled `Collect real examples of calibrated final answers`.

Week 1:

- Publish a small comparison post: "Before and after installing impostor syndrome in an AI coding agent."
- Ask users to paste examples where an agent said "done" too early.
- Add a `Good examples` section only if real examples are better than the current synthetic ones.

## Post Copy

Short post:

```text
I gave my AI agent impostor syndrome.

Not the theatrical kind. The useful kind:
- check what it actually verified
- remember when the last attempt failed
- admit what remains uncertain
- stop saying "fixed" without tests

Tiny Agent Skill:
https://github.com/flyrev/impostor-syndrome-ai-skill

Install it, try one coding task, and star it if it stops one fake "done."
```

Developer post:

```text
The most useful AI agent behavior I want is not "be more confident".

It is:
- say what you inspected
- say what you tested
- say what contradicted you
- say what remains unverified
- only then claim the task is done

I packaged that as a tiny Codex skill:
https://github.com/flyrev/impostor-syndrome-ai-skill
```

Discussion post:

```text
AI coding agents need a stronger final-answer contract.

"Fixed it" is not enough. I want:
1. what changed
2. what was verified
3. what was not verified
4. what could still be wrong

I made a tiny skill for that pattern:
https://github.com/flyrev/impostor-syndrome-ai-skill

What would you add to the checklist?
```

Hacker News style:

```text
Show HN: Impostor Syndrome for AI Agents

I got tired of AI coding agents saying "fixed" or "done" after they had not run tests, checked assumptions, or verified anything.

So I made a tiny Agent Skill that gives them operational impostor syndrome: before making confident claims, they review what they actually verified, what they got wrong earlier in the task, and what remains uncertain.

It is intentionally small and works as a reusable SKILL.md.
https://github.com/flyrev/impostor-syndrome-ai-skill

I would be curious whether people think this should be a general agent behavior, a skill, or a stricter pre-completion checklist.
```

Reddit style:

```text
I keep seeing AI coding agents end with "fixed" when the honest answer is "changed, but not verified in the browser".

I made a tiny Codex skill that forces the final answer to check:
- what was verified
- what failed or contradicted the agent
- what remains uncertain
- whether the final confidence matches the evidence

It is intentionally small and boring:
https://github.com/flyrev/impostor-syndrome-ai-skill

I would be interested in examples of better final-answer contracts.
```

Funny angle:

```text
New rule: AI agents should not be allowed to say "fixed" unless they can name the test, command, source, or file that proved it.

So I made a tiny skill that gives them impostor syndrome:
https://github.com/flyrev/impostor-syndrome-ai-skill
```

Practical angle:

```text
I made a small Agent Skill for calibrated confidence.

It forces an AI agent to check:
1. What did I verify?
2. What did I not verify?
3. Did I already get something wrong in this task?
4. Am I overstating certainty?

Useful for coding agents, debugging, PR review, and research:
https://github.com/flyrev/impostor-syndrome-ai-skill
```

Meme angle:

```text
AI agents need less "CEO energy" and more "junior engineer who actually ran the tests" energy.

I made a skill for that:
https://github.com/flyrev/impostor-syndrome-ai-skill
```

## Comment Replies

If someone says this is just prompting:

```text
Yes. The useful part is making the check durable and operational: it runs before confident claims, final answers, "fixed", "done", and "ready" states. Small prompts matter when they sit at the right control point.
```

If someone says this will make agents verbose:

```text
That is the failure mode I wanted to avoid. The skill explicitly says not to perform theatrical self-doubt. The target output is concise: what was verified, what was not, and what confidence is justified.
```

If someone asks why the name is negative:

```text
The name is the hook. The behavior is not anxiety or self-deprecation; it is operational calibration before claims of completion.
```

## Metrics To Watch

- Stars are attention.
- Forks are intent to adapt.
- Issues with examples are the strongest signal.
- Quotes and screenshots mean the phrase is spreading.
- Pull requests that tighten the checklist mean the idea is becoming community-owned.

## Commands

Validate and publish:

```sh
gh skill publish --dry-run
gh skill publish --tag v0.1.0
```

Add topics:

```sh
gh repo edit flyrev/impostor-syndrome-ai-skill \
  --add-topic agent-skills \
  --add-topic ai-agents \
  --add-topic codex \
  --add-topic claude-code \
  --add-topic prompt-engineering \
  --add-topic llm \
  --add-topic ai-safety \
  --add-topic developer-tools \
  --add-topic uncertainty \
  --add-topic verification
```

Check discoverability after publishing:

```sh
gh skill search impostor
gh skill search uncertainty
gh skill search verification
gh skill search overconfidence
```

## What Not To Do

- Do not claim the skill eliminates hallucinations.
- Do not over-explain agent safety theory in the first post.
- Do not spam unrelated communities.
- Do not make the README sound like a product landing page.
- Do not add a huge framework around a skill whose advantage is being small.

## References

- GitHub README guidance: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository
- GitHub social preview guidance: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/customizing-your-repositorys-social-media-preview
- OpenAI Agent Skills guidance: https://developers.openai.com/codex/skills
- GitHub CLI skill publish: https://cli.github.com/manual/gh_skill_publish
- GitHub CLI skill install: https://cli.github.com/manual/gh_skill_install
- GitHub CLI skill search: https://cli.github.com/manual/gh_skill_search
