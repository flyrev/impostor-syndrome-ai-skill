#!/bin/sh
# Maintainer-only automation. Not required for installing or using the skill.
set -eu

REPO_DIR="/Users/christian/impostor-syndrome-ai-skill"
CODEX_BIN="/opt/homebrew/bin/codex"
GH_BIN="/opt/homebrew/bin/gh"
REPO_SLUG="flyrev/impostor-syndrome-ai-skill"
BASE_BRANCH="main"
PROPOSAL_BRANCH="auto/improve-skill"
COMPARE_URL="https://github.com/${REPO_SLUG}/compare/${BASE_BRANCH}...${PROPOSAL_BRANCH}"
SKILL_FILE="skills/flyrev/impostor-syndrome/SKILL.md"
LOG_ROOT="${HOME:-/Users/christian}/Library/Logs/impostor-syndrome-ai-skill"
LOCK_DIR="${TMPDIR:-/tmp}/impostor-syndrome-ai-skill-auto-improve.lock"
RUN_ID="$(date -u '+%Y%m%d%H%M%S')"
WORKTREE_DIR="${TMPDIR:-/tmp}/impostor-syndrome-ai-skill-auto-worktree-${RUN_ID}"
CREATED_LOCAL_BRANCH=0

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export GIT_SSH_COMMAND="${GIT_SSH_COMMAND:-ssh -o BatchMode=yes}"
export GH_PROMPT_DISABLED=1

mkdir -p "$LOG_ROOT"
exec >>"$LOG_ROOT/auto-improve.log" 2>&1

echo "== $(date '+%Y-%m-%d %H:%M:%S %z') starting auto-improve run =="

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  echo "another auto-improve run is already active; exiting"
  exit 0
fi

cleanup() {
  if git -C "$REPO_DIR" worktree list --porcelain 2>/dev/null | grep -Fqx "worktree $WORKTREE_DIR"; then
    git -C "$REPO_DIR" worktree remove --force "$WORKTREE_DIR" 2>/dev/null || true
  fi
  if [ "$CREATED_LOCAL_BRANCH" = "1" ] && git -C "$REPO_DIR" show-ref --verify --quiet "refs/heads/$PROPOSAL_BRANCH"; then
    git -C "$REPO_DIR" branch -D "$PROPOSAL_BRANCH" 2>/dev/null || true
  fi
  rmdir "$LOCK_DIR" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

if [ ! -x "$CODEX_BIN" ]; then
  echo "codex CLI not found or not executable at $CODEX_BIN"
  exit 1
fi

cd "$REPO_DIR"

if git ls-remote --exit-code --heads origin "$PROPOSAL_BRANCH" >/dev/null 2>&1; then
  echo "proposal branch $PROPOSAL_BRANCH already exists; waiting for review"
  echo "review URL: $COMPARE_URL"
  exit 0
else
  ls_remote_status=$?
  if [ "$ls_remote_status" -ne 2 ]; then
    echo "could not check remote proposal branch $PROPOSAL_BRANCH"
    exit "$ls_remote_status"
  fi
fi

if git show-ref --verify --quiet "refs/heads/$PROPOSAL_BRANCH"; then
  echo "local proposal branch $PROPOSAL_BRANCH already exists; refusing to overwrite it"
  exit 1
fi

git fetch origin "$BASE_BRANCH"
git worktree add -b "$PROPOSAL_BRANCH" "$WORKTREE_DIR" "origin/$BASE_BRANCH"
CREATED_LOCAL_BRANCH=1

cd "$WORKTREE_DIR"

if [ -n "$(git status --porcelain)" ]; then
  echo "new worktree is not clean before automation; exiting"
  git status --short
  exit 1
fi

PROMPT_FILE="$LOCK_DIR/prompt.md"
LAST_MESSAGE="$LOG_ROOT/last-codex-message.md"

cat >"$PROMPT_FILE" <<'PROMPT'
You are running from an unattended cron job in /Users/christian/impostor-syndrome-ai-skill.

Task: make exactly one focused, small improvement to this Codex skill.

Constraints:
- Read skills/flyrev/impostor-syndrome/SKILL.md first.
- Edit only skills/flyrev/impostor-syndrome/SKILL.md.
- Do not create, rename, or delete files.
- Do not commit, push, change branches, or run network commands.
- Preserve the skill's purpose: calibrated confidence through evidence review, recent-track-record review, uncertainty identification, and evidence-matched communication.
- Prefer improvements that make the skill more operational: clearer decision rules, better examples, sharper anti-patterns, installation guidance, or concise verification guidance.
- If no useful improvement is apparent, leave the repository unchanged and explain why.
- Before finishing, inspect the diff and ensure it is coherent and limited to skills/flyrev/impostor-syndrome/SKILL.md.
PROMPT

"$CODEX_BIN" exec \
  -C "$WORKTREE_DIR" \
  --sandbox workspace-write \
  --ask-for-approval never \
  --output-last-message "$LAST_MESSAGE" \
  - <"$PROMPT_FILE"

if [ -z "$(git status --porcelain)" ]; then
  echo "codex produced no repository changes; exiting"
  exit 0
fi

unexpected_files="$(git status --porcelain | awk '{print $2}' | grep -vxF "$SKILL_FILE" || true)"
if [ -n "$unexpected_files" ]; then
  echo "unexpected files changed; refusing to commit"
  git status --short
  exit 1
fi

if [ ! -s "$SKILL_FILE" ]; then
  echo "$SKILL_FILE is missing or empty; refusing to commit"
  exit 1
fi

git diff --check
git diff -- "$SKILL_FILE"

git add "$SKILL_FILE"
git commit -m "docs: improve impostor syndrome skill"
git push -u origin "$PROPOSAL_BRANCH"

PR_BODY_FILE="$LOCK_DIR/pr-body.md"
cat >"$PR_BODY_FILE" <<'BODY'
Automated proposal from the every-two-hours skill-improvement cron job.

Review checklist:
- Is this actually an improvement to calibrated confidence?
- Does it avoid turning uncertainty into theatrical self-doubt?
- Is the change limited to skills/flyrev/impostor-syndrome/SKILL.md?
- Should the improvement process itself change before merging?
BODY

if [ -x "$GH_BIN" ] && pr_url="$("$GH_BIN" pr create \
    --repo "$REPO_SLUG" \
    --base "$BASE_BRANCH" \
    --head "$PROPOSAL_BRANCH" \
    --title "docs: propose impostor syndrome skill improvement" \
    --body-file "$PR_BODY_FILE")"; then
  echo "auto-improve run opened proposal PR: $pr_url"
else
  echo "auto-improve run pushed proposal branch: $PROPOSAL_BRANCH"
  echo "gh PR creation was unavailable; review URL: $COMPARE_URL"
fi
