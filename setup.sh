#!/bin/bash
set -e

# Claude Code Cost Optimizer Setup Script
# One-click install for all cost-saving tools and configurations

# Check bash version (requires 4+)
if ((BASH_VERSINFO[0] < 4)); then
    echo "Error: This script requires Bash 4.0 or higher"
    echo "Current version: $BASH_VERSION"
    echo
    echo "On macOS, install with: brew install bash"
    echo "Then run with: /usr/local/bin/bash setup.sh"
    exit 1
fi

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}ℹ${NC} $1"; }
log_success() { echo -e "${GREEN}✓${NC} $1"; }
log_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
log_error()   { echo -e "${RED}✗${NC} $1"; }

INTERACTIVE=false
if [[ "$1" == "--interactive" ]]; then
    INTERACTIVE=true
fi

confirm() {
    if [[ "$INTERACTIVE" == "true" ]]; then
        read -p "$1 [y/N] " -n 1 -r
        echo
        [[ $REPLY =~ ^[Yy]$ ]]
    else
        return 0
    fi
}

echo "╔════════════════════════════════════════════════════════════╗"
echo "║   Claude Code Cost Optimizer — One-Click Setup            ║"
echo "║   Target: 70–75% cost reduction                           ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo

# ── Prerequisites ──────────────────────────────────────────────
if ! command -v claude &> /dev/null; then
    log_error "Claude Code CLI not found. Install first:"
    echo "  npm install -g @anthropic-ai/claude-code"
    exit 1
fi

CLAUDE_VERSION=$(claude --version 2>&1 | head -1 || echo "unknown")
log_success "Claude Code CLI: $CLAUDE_VERSION"

mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/agents" "$CLAUDE_DIR/backups"

# Backup existing config
if [[ -f "$CLAUDE_DIR/settings.json" ]]; then
    if confirm "Backup existing settings.json?"; then
        BACKUP_DIR="$CLAUDE_DIR/backups/$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$BACKUP_DIR"
        cp "$CLAUDE_DIR/settings.json" "$BACKUP_DIR/" 2>/dev/null || true
        cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP_DIR/" 2>/dev/null || true
        log_success "Backed up to $BACKUP_DIR"
    fi
fi

# ── Stage 1: Core tools ────────────────────────────────────────
echo
echo "── Stage 1: Core tools ─────────────────────────────────────"

# claudetop
log_info "Installing claudetop (cost monitoring)..."
if ! command -v claudetop &> /dev/null; then
    if command -v npm &> /dev/null; then
        npm install -g claudetop && log_success "claudetop installed" || log_warning "claudetop install failed — run manually: npm install -g claudetop"
    else
        log_warning "npm not found — install Node.js first, then: npm install -g claudetop"
    fi
else
    log_success "claudetop already installed"
fi

# GitNexus
log_info "Installing GitNexus (code intelligence)..."
if ! command -v gitnexus &> /dev/null; then
    if command -v npm &> /dev/null; then
        npm install -g gitnexus && log_success "GitNexus installed" || log_warning "GitNexus install failed — run manually: npm install -g gitnexus"
    else
        log_warning "npm not found — run manually: npm install -g gitnexus"
    fi
else
    log_success "GitNexus already installed"
fi

# RTK
log_info "Installing RTK (terminal output compression)..."
if command -v rtk &> /dev/null && rtk gain &> /dev/null; then
    log_success "RTK already installed"
else
    if command -v brew &> /dev/null; then
        log_info "  Checking brew formula for RTK..."
        # Install from tap to avoid name collision with 'Rust Type Kit'
        if brew tap rtk-ai/rtk 2>/dev/null && brew install rtk-ai/rtk/rtk 2>/dev/null; then
            log_success "RTK installed via brew tap"
        elif brew install rtk 2>/dev/null; then
            # Verify it's the right RTK
            if rtk gain &> /dev/null; then
                log_success "RTK installed"
            else
                log_warning "brew installed 'rtk' but 'rtk gain' failed — may be wrong package"
                log_info "  See: https://github.com/rtk-ai/rtk for manual install"
            fi
        else
            log_warning "brew install rtk failed — see: https://github.com/rtk-ai/rtk"
        fi
    else
        log_warning "brew not found — install RTK manually: https://github.com/rtk-ai/rtk"
    fi
fi

# RTK hook
if command -v rtk &> /dev/null && rtk gain &> /dev/null; then
    log_info "Initialising RTK PreToolUse hook..."
    rtk init -g --auto-patch 2>/dev/null && log_success "RTK hook configured" || log_info "RTK hook may already be configured"
fi

# ── Stage 2: settings.json (model + plugins) ───────────────────
echo
echo "── Stage 2: Model switching + Claude plugins ───────────────"

PLUGIN_CONFIG='{
  "model": "opusplan",
  "enabledPlugins": {
    "caveman@caveman": true,
    "ponytail@ponytail": true,
    "context-mode@context-mode": true,
    "code-review-graph@code-review-graph": true
  },
  "extraKnownMarketplaces": {
    "caveman": {"source": {"source": "github", "repo": "JuliusBrussee/caveman"}},
    "ponytail": {"source": {"source": "github", "repo": "DietrichGebert/ponytail"}},
    "context-mode": {"source": {"source": "github", "repo": "mksglu/context-mode"}},
    "code-review-graph": {"source": {"source": "github", "repo": "tirth8205/code-review-graph"}}
  }
}'

log_info "Configuring settings.json (opusplan model + all plugins)..."
if [[ -f "$CLAUDE_DIR/settings.json" ]] && command -v jq &> /dev/null; then
    # Merge — preserve any existing user settings, add ours on top
    jq --argjson new "$PLUGIN_CONFIG" '. * $new' "$CLAUDE_DIR/settings.json" > /tmp/cco_settings.json \
        && mv /tmp/cco_settings.json "$CLAUDE_DIR/settings.json" \
        && log_success "settings.json merged (existing settings preserved)" \
        || { log_error "jq merge failed"; exit 1; }
elif command -v jq &> /dev/null; then
    echo "$PLUGIN_CONFIG" | jq . > "$CLAUDE_DIR/settings.json" \
        && log_success "settings.json written"
else
    # No jq — write template directly
    cp "$SCRIPT_DIR/templates/settings.json" "$CLAUDE_DIR/settings.json" \
        && log_success "settings.json written (install jq for smarter merging: brew install jq)" \
        || { log_error "Failed to write settings.json"; exit 1; }
fi

log_info "Plugins enabled: caveman · ponytail · context-mode · code-review-graph"
log_info "These load from GitHub on next Claude session — no separate install needed"

# ── Stage 3: CLAUDE.md + permissions ──────────────────────────
echo
echo "── Stage 3: Instructions + permissions ─────────────────────"

if cp "$SCRIPT_DIR/templates/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"; then
    log_success "Global CLAUDE.md configured"
else
    log_warning "Failed to copy CLAUDE.md — copy manually: cp templates/CLAUDE.md ~/.claude/"
fi

if cp "$SCRIPT_DIR/templates/settings.local.json" "$CLAUDE_DIR/settings.local.json"; then
    log_success "Permissions configured (settings.local.json)"
else
    log_warning "Failed to copy settings.local.json"
fi

# ── Stage 4: journal-recorder agent ───────────────────────────
echo
echo "── Stage 4: journal-recorder agent ─────────────────────────"
log_info "Installing journal-recorder-agent (auto-saves every session)..."
JOURNAL_URL="https://raw.githubusercontent.com/GauravRatnawat/journal-recorder-agent/main/journal-recorder.md"
if curl -fsSL "$JOURNAL_URL" -o "$CLAUDE_DIR/agents/journal-recorder.md" 2>/dev/null; then
    log_success "journal-recorder-agent installed → ~/.claude/agents/journal-recorder.md"
else
    log_warning "Failed to download journal-recorder-agent (check internet / GitHub access)"
    log_info "  Manual: curl -o ~/.claude/agents/journal-recorder.md $JOURNAL_URL"
fi

# ── Stage 5: gstack skills ────────────────────────────────────
echo
echo "── Stage 5: gstack automation skills ───────────────────────"
log_info "Checking for gstack (/review, /qa, /ship, /browse, /retro)..."
if [[ -d "$CLAUDE_DIR/skills/gstack" ]]; then
    log_success "gstack already installed"
elif [[ -d "$SCRIPT_DIR/skills/gstack" ]]; then
    ln -sf "$SCRIPT_DIR/skills/gstack" "$CLAUDE_DIR/skills/gstack"
    log_success "gstack linked from repo"
elif [[ -d "$HOME/gstack" ]]; then
    if confirm "Found gstack in $HOME/gstack. Link it?"; then
        ln -sf "$HOME/gstack" "$CLAUDE_DIR/skills/gstack"
        log_success "gstack linked"
    fi
else
    log_warning "gstack not found"
    echo
    echo "  Install gstack for one-command workflows (/review, /qa, /ship):"
    echo "    git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack"
    echo "    cd ~/.claude/skills/gstack && npm install"
    echo
    echo "  Full guide: $SCRIPT_DIR/docs/GSTACK_INSTALL.md"
fi

# ── Stage 6: Optional checks ──────────────────────────────────
echo
echo "── Stage 6: Optional tools ─────────────────────────────────"

# Conductor
log_info "Checking for Conductor (workspace isolation)..."
if [[ -d "$HOME/Library/Application Support/com.conductor.app" ]]; then
    log_success "Conductor detected"
else
    log_info "Conductor not found — optional but recommended: https://conductor.app"
fi

# Handy
log_info "Checking for Handy (voice-to-text)..."
if [[ -d "/Applications/Handy.app" ]]; then
    log_success "Handy detected — voice input ready"
else
    log_info "Handy not found — optional: https://github.com/handy-app/handy"
fi

# BMAD
log_info "Installing BMAD (agile AI dev framework)..."
if [[ -d "_bmad" ]] || [[ -d "$SCRIPT_DIR/_bmad" ]]; then
    log_success "BMAD already installed in this project"
else
    if command -v npx &> /dev/null; then
        npx bmad-method install \
            --modules bmm,bmb \
            --tools claude-code \
            --yes \
            --directory "$SCRIPT_DIR" \
            --user-name "${USER:-user}" 2>&1 | tail -5 \
            && log_success "BMAD installed (49 skills → .claude/skills/)" \
            || log_warning "BMAD install failed — run manually: npx bmad-method"
    else
        log_warning "npx not found — install BMAD manually: npx bmad-method"
    fi
fi

# ── Summary ────────────────────────────────────────────────────
echo
echo "╔════════════════════════════════════════════════════════════╗"
echo "║   Setup Complete!                                          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo
log_success "Configuration applied to $CLAUDE_DIR"
echo
echo "📊 Verify installation:"
echo
echo "  ${BLUE}claudetop --today${NC}          # cost dashboard"
echo "  ${BLUE}rtk gain${NC}                   # RTK compression stats"
echo "  ${BLUE}gitnexus --version${NC}         # code intelligence"
echo
echo "🔌 Plugins active on next Claude session:"
echo "  ${GREEN}caveman${NC}       /caveman       response compression"
echo "  ${GREEN}ponytail${NC}      /ponytail      lazy-efficient responses"
echo "  ${GREEN}context-mode${NC}  ctx stats      tool output sandboxing"
echo "  ${GREEN}code-review-graph${NC}  /code-review-graph:build-graph"
echo
echo "⚡ Automation skills (if gstack installed):"
echo "  ${BLUE}/review${NC}   /qa   /ship   /browse   /retro"
echo
echo "  ${GREEN}bmad${NC}          /bmad-help      49 skills installed"
echo
echo "🚀 Start a new Claude session to activate all changes"
echo
echo "📖 Docs: $SCRIPT_DIR/README.md"
echo "❓ Help: $SCRIPT_DIR/FAQ.md"
echo
log_info "Expected: 70–75% cost reduction"
echo
