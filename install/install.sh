#!/usr/bin/env bash
set -euo pipefail

# adhd-mode installer
# Rules adapted from https://github.com/ayghri/i-have-adhd (MIT)
# Repo: https://github.com/DevAnimecx/adhd-mode

VERSION="1.0.0"
RAW_BASE="${ADHD_MODE_RAW:-https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main}"
MODE="project"
STRATEGY="safe"
ONLY=""
DRY_RUN=0

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

usage() { cat <<'EOF'
Usage: ./install.sh [OPTIONS]
  (default)   install for all tools into the CURRENT project
  --global    install user-level rules
  --tool N    one tool: agents|cursor|copilot|windsurf|gemini|codex|claude
  --overwrite replace existing file (backup kept)
  --list      dry run
  -h, --help  this help
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --global) MODE="global" ;; --overwrite) STRATEGY="overwrite" ;;
    --list) DRY_RUN=1 ;; --tool) ONLY="${2:-}"; shift ;;
    -h|--help) usage; exit 0 ;; *) echo "unknown: $1" >&2; usage; exit 1 ;;
  esac; shift
done

rule_path() { case "$1" in
  agents) echo "AGENTS.md" ;; cursor) echo "rules/cursor/adhd-mode.mdc" ;;
  copilot) echo "rules/copilot/copilot-instructions.md" ;;
  windsurf) echo "rules/windsurf/rules/adhd-mode.md" ;;
  gemini) echo "rules/gemini/GEMINI.md" ;; codex) echo "rules/codex/AGENTS.md" ;;
  claude) echo "claude/SKILL.md" ;; esac
}

dest_for() { case "$1:$MODE" in
  agents:project) echo "AGENTS.md" ;; agents:global) echo "$HOME/.codex/AGENTS.md" ;;
  cursor:project) echo ".cursor/rules/adhd-mode.mdc" ;; cursor:global) echo "$HOME/.cursor/rules/adhd-mode.mdc" ;;
  copilot:project) echo ".github/copilot-instructions.md" ;; copilot:global) echo "$HOME/.copilot/copilot-instructions.md" ;;
  windsurf:project) echo ".windsurf/rules/adhd-mode.md" ;; windsurf:global) echo "$HOME/.codeium/windsurf/rules/adhd-mode.md" ;;
  gemini:project) echo "GEMINI.md" ;; gemini:global) echo "$HOME/.gemini/GEMINI.md" ;;
  codex:project) echo "AGENTS.md" ;; codex:global) echo "$HOME/.codex/AGENTS.md" ;;
  claude:project) echo ".claude/skills/adhd-mode/SKILL.md" ;; claude:global) echo "$HOME/.claude/skills/adhd-mode/SKILL.md" ;;
esac
}

strip_frontmatter() { awk 'NR==1 && /^---[[:space:]]*$/ {fm=1; next} fm && /^---[[:space:]]*$/ {fm=0; next} !fm'; }

place() {
  local tool="$1" dest="$2" full="$3" merge_body="$4"
  if [ "$DRY_RUN" = "1" ]; then
    [ -f "$dest" ] && echo "  [dry-run] $tool -> $dest (exists: would merge)" || echo "  [dry-run] $tool -> $dest (new)"
    return 0
  fi
  mkdir -p "$(dirname "$dest")"
  if [ -f "$dest" ] && grep -q "adhd-mode v$VERSION" "$dest" 2>/dev/null; then
    echo "  =  $tool: already at $dest, skipping"; return 0
  fi
  if [ ! -f "$dest" ]; then printf '%s\n' "$full" > "$dest"; echo "  +  $tool: $dest"; return 0; fi
  cp "$dest" "$dest.bak-adhd-mode"
  if [ "$STRATEGY" = "overwrite" ]; then printf '%s\n' "$full" > "$dest"; echo "  +  $tool: $dest (replaced; backup kept)"
  else { echo ""; echo "<!-- adhd-mode v$VERSION (begin) -->"; printf '%s\n' "$merge_body"; echo "<!-- adhd-mode (end) -->"; } >> "$dest"
    echo "  +  $tool: merged into $dest (backup kept)"; fi
}

echo "adhd-mode v$VERSION installer"
echo "mode: $MODE | strategy: $STRATEGY${ONLY:+ | tool: $ONLY}"
echo

for tool in agents cursor copilot windsurf gemini codex claude; do
  [ -n "$ONLY" ] && [ "$ONLY" != "$tool" ] && continue
  rel="$(rule_path "$tool")"; dest="$(dest_for "$tool")"
  if [ -f "$REPO_ROOT/$rel" ]; then full="$(cat "$REPO_ROOT/$rel")"
  else full="$(curl -fsSL "$RAW_BASE/$rel")" || { echo "  !  $tool: fetch failed, skipping" >&2; continue; }
  fi
  merge_body="$(printf '%s\n' "$full" | strip_frontmatter)"
  place "$tool" "$dest" "$full" "$merge_body"
done

if [ -z "$ONLY" ] || [ "$ONLY" = "agents" ] || [ "$ONLY" = "claude" ]; then
  claude_dest="CLAUDE.md"; [ "$MODE" = "global" ] && claude_dest="$HOME/.claude/CLAUDE.md"
  if [ "$DRY_RUN" = "1" ]; then echo "  [dry-run] claude-md -> $claude_dest"
  elif [ ! -f "$claude_dest" ] || ! grep -q "@AGENTS.md" "$claude_dest" 2>/dev/null; then
    if [ -f "$claude_dest" ]; then cp "$claude_dest" "$claude_dest.bak-adhd-mode"; echo "" >> "$claude_dest"; echo "@AGENTS.md" >> "$claude_dest"
      echo "  +  claude-md: added @AGENTS.md to $claude_dest (backup kept)"
    else printf '# CLAUDE.md\n\n@AGENTS.md\n' > "$claude_dest"; echo "  +  claude-md: $claude_dest"; fi
  else echo "  =  claude-md: @AGENTS.md already present, skipping"; fi
fi

echo; echo "Done. Restart your editor. Say \"stop adhd mode\" to pause."
