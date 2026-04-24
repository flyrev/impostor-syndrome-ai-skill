#!/bin/sh
set -eu

REPO_DIR="/Users/christian/impostor-syndrome-ai-skill"
CODEX_BIN="/opt/homebrew/bin/codex"
BRANCH="main"
LOG_ROOT="${HOME:-/Users/christian}/Library/Logs/impostor-syndrome-ai-skill"
LOCK_DIR="${TMPDIR:-/tmp}/impostor-syndrome-ai-skill-auto-improve.lock"

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export GIT_SSH_COMMAND="${GIT_SSH_COMMAND:-ssh -o BatchMode=yes}"

mkdir -p "$LOG_ROOT"
exec >>"$LOG_ROOT/auto-improve.log" 2>&1

echo "== $(date '+%Y-%m-%d %H:%M:%S %z') starting auto-improve run =="

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  echo "another auto-improve run is already active; exiting"
  exit 0
fi

cleanup() {
  rmdir "$LOCK_DIR" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

if [ ! -x "$CODEX_BIN" ]; then
  echo "codex CLI not found or not executable at $CODEX_BIN"
  exit 1
fi

cd "$REPO_DIR"

current_branch="$(git branch --show-current)"
if [ "$current_branch" != "$BRANCH" ]; then
  echo "expected branch $BRANCH, found $current_branch; exiting"
  exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
  echo "working tree is not clean before automation; exiting"
  git status --short
  exit 1
fi

git fetch origin "$BRANCH"
git pull --ff-only origin "$BRANCH"

if [ -n "$(git status --porcelain)" ]; then
  echo "working tree is not clean after pull; exiting"
  git status --short
  exit 1
fi

PROMPT_FILE="$LOCK_DIR/prompt.md"
LAST_MESSAGE="$LOG_ROOT/last-codex-message.md"

cat >"$PROMPT_FILE" <<'PROMPT'
You are running from an unattended cron job in /Users/christian/impostor-syndrome-ai-skill.

Task: make exactly one focused, small improvement to this Codex skill.

Constraints:
- Read SKILL.md first.
- Edit only SKILL.md.
- Do not create, rename, or delete files.
- Do not commit, push, change branches, or run network commands.
- Preserve the skill's purpose: calibrated confidence through evidence review, recent-track-record review, uncertainty identification, and evidence-matched communication.
- Prefer improvements that make the skill more operational: clearer decision rules, better examples, sharper anti-patterns, installation guidance, or concise verification guidance.
- If no useful improvement is apparent, leave the repository unchanged and explain why.
- Before finishing, inspect the diff and ensure it is coherent and limited to SKILL.md.
PROMPT

"$CODEX_BIN" exec \
  -C "$REPO_DIR" \
  --sandbox workspace-write \
  --ask-for-approval never \
  --output-last-message "$LAST_MESSAGE" \
  - <"$PROMPT_FILE"

if [ -z "$(git status --porcelain)" ]; then
  echo "codex produced no repository changes; exiting"
  exit 0
fi

unexpected_files="$(git status --porcelain | awk '{print $2}' | grep -v '^SKILL.md$' || true)"
if [ -n "$unexpected_files" ]; then
  echo "unexpected files changed; refusing to commit"
  git status --short
  exit 1
fi

if [ ! -s SKILL.md ]; then
  echo "SKILL.md is missing or empty; refusing to commit"
  exit 1
fi

git diff --check
git diff -- SKILL.md

git add SKILL.md
git commit -m "docs: improve impostor syndrome skill"
git push origin "$BRANCH"

echo "auto-improve run committed and pushed successfully"
