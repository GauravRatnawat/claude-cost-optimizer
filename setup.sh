#!/bin/bash
set -e

# Claude Code Cost Optimizer Setup Script
# Automates installation of cost-saving tools and configurations

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
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}ℹ${NC} $1"; }
log_success() { echo -e "${GREEN}✓${NC} $1"; }
log_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
log_error() { echo -e "${RED}✗${NC} $1"; }

# Interactive mode flag
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
echo "║   Claude Code Cost Optimizer Setup                        ║"
echo "║   Target: 70% cost reduction with enhanced productivity   ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    log_error "Claude Code CLI not found. Please install it first:"
    echo "  npm install -g @anthropic-ai/claude-code"
    echo
    echo "After installation, run this setup script again."
    exit 1
fi

CLAUDE_VERSION=$(claude --version 2>&1 | head -1 || echo "unknown")
log_success "Claude Code CLI detected: $CLAUDE_VERSION"

# Create necessary directories
log_info "Creating configuration directories..."
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/projects"
mkdir -p "$CLAUDE_DIR/backups"

# Backup existing configuration
if [[ -f "$CLAUDE_DIR/settings.json" ]]; then
    if confirm "Backup existing configuration?"; then
        BACKUP_DIR="$CLAUDE_DIR/backups/$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$BACKUP_DIR"
        cp -r "$CLAUDE_DIR"/*.json "$BACKUP_DIR/" 2>/dev/null || true
        cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP_DIR/" 2>/dev/null || true
        log_success "Backed up to $BACKUP_DIR"
    fi
fi

# 1. Install claudetop
log_info "Installing claudetop (cost monitoring)..."
if ! command -v claudetop &> /dev/null; then
    if command -v npm &> /dev/null; then
        if npm install -g claudetop; then
            log_success "claudetop installed successfully"
            # Verify installation
            if command -v claudetop &> /dev/null; then
                log_info "Verified: $(claudetop --version 2>&1 | head -1 || echo 'claudetop ready')"
            else
                log_warning "claudetop installed but not in PATH. You may need to restart your shell."
            fi
        else
            log_error "Failed to install claudetop"
            log_warning "You can install it manually later: npm install -g claudetop"
        fi
    else
        log_warning "npm not found. Please install Node.js first."
        log_info "After installing Node.js, run: npm install -g claudetop"
    fi
else
    log_success "claudetop already installed"
    claudetop --version 2>&1 | head -1 | sed 's/^/  /' || true
fi

# 2. Install GitNexus
log_info "Installing GitNexus (intelligent code navigation)..."
if ! command -v gitnexus &> /dev/null; then
    if command -v npm &> /dev/null; then
        if npm install -g gitnexus; then
            log_success "GitNexus installed successfully"
            # Verify installation
            if command -v gitnexus &> /dev/null; then
                log_info "Verified: $(gitnexus --version 2>&1 | head -1 || echo 'GitNexus ready')"
            else
                log_warning "GitNexus installed but not in PATH. You may need to restart your shell."
            fi
        else
            log_error "Failed to install GitNexus"
            log_warning "You can install it manually later: npm install -g gitnexus"
        fi
    else
        log_warning "npm not found. Please install Node.js first."
        log_info "After installing Node.js, run: npm install -g gitnexus"
    fi
else
    log_success "GitNexus already installed"
    gitnexus --version 2>&1 | head -1 | sed 's/^/  /' || true
fi

# 2b. Install code-review-graph (MCP server)
log_info "Checking for code-review-graph (AI-powered code review)..."
if command -v python3 &> /dev/null || command -v pip3 &> /dev/null; then
    log_warning "code-review-graph is an MCP server - manual setup required"
    echo
    echo "  code-review-graph provides:"
    echo "  • Impact radius analysis for blast-radius detection"
    echo "  • Delta reviews (review only changes since last commit)"
    echo "  • PR reviews with full structural context"
    echo "  • Semantic code search with knowledge graphs"
    echo
    echo "  📥 To install code-review-graph:"
    echo "     GitHub: https://github.com/tirth8205/code-review-graph"
    echo "     Follow the MCP server setup instructions in the repository"
    echo
    echo "  Skills available after installation:"
    echo "     /review-delta  - Review only recent changes"
    echo "     /review-pr     - Review a PR or branch diff"
    echo "     /build-graph   - Build/update the knowledge graph"
    echo
else
    log_warning "Python not found. code-review-graph requires Python 3.8+"
    log_info "Install Python first, then visit: https://github.com/tirth8205/code-review-graph"
fi

# 3. Configure opusplan model
log_info "Configuring opusplan model (smart model switching)..."
if cat > "$CLAUDE_DIR/settings.json" << 'EOF'
{
  "model": "opusplan",
  "enabledPlugins": {}
}
EOF
then
    # Validate JSON
    if command -v jq &> /dev/null; then
        if jq empty "$CLAUDE_DIR/settings.json" 2>/dev/null; then
            log_success "Model configuration set to opusplan (validated)"
        else
            log_error "Invalid JSON in settings.json"
            exit 1
        fi
    else
        log_success "Model configuration set to opusplan"
        log_info "Tip: Install jq for JSON validation: brew install jq"
    fi
else
    log_error "Failed to write settings.json"
    exit 1
fi

# 4. Set up global CLAUDE.md
log_info "Creating global CLAUDE.md instructions..."
if cp "$SCRIPT_DIR/templates/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"; then
    log_success "Global instructions configured"
    log_info "  Location: $CLAUDE_DIR/CLAUDE.md"
else
    log_error "Failed to copy CLAUDE.md"
    log_warning "You can copy it manually: cp templates/CLAUDE.md ~/.claude/"
fi

# 5. Set up permissions
log_info "Configuring safe command permissions..."
if cp "$SCRIPT_DIR/templates/settings.local.json" "$CLAUDE_DIR/settings.local.json"; then
    # Validate JSON if jq is available
    if command -v jq &> /dev/null; then
        if jq empty "$CLAUDE_DIR/settings.local.json" 2>/dev/null; then
            log_success "Permissions configured (validated)"
        else
            log_error "Invalid JSON in settings.local.json"
            exit 1
        fi
    else
        log_success "Permissions configured"
    fi
else
    log_error "Failed to copy settings.local.json"
    log_warning "You can copy it manually: cp templates/settings.local.json ~/.claude/"
fi

# 6. Set up GitNexus hooks
log_info "Configuring GitNexus pre-hooks..."
if cp "$SCRIPT_DIR/templates/hooks.json" "$CLAUDE_DIR/hooks.json"; then
    # Validate JSON if jq is available
    if command -v jq &> /dev/null; then
        if jq empty "$CLAUDE_DIR/hooks.json" 2>/dev/null; then
            log_success "GitNexus hooks configured (validated)"
        else
            log_error "Invalid JSON in hooks.json"
            exit 1
        fi
    else
        log_success "GitNexus hooks configured"
    fi
    # Only applies if GitNexus is installed
    if ! command -v gitnexus &> /dev/null; then
        log_info "  Note: Hooks will activate once GitNexus is installed"
    fi
else
    log_error "Failed to copy hooks.json"
    log_warning "You can copy it manually: cp templates/hooks.json ~/.claude/"
fi

# 7. Install gstack skills (optional)
log_info "Installing gstack automation skills..."

# Check if gstack is already installed in Claude skills directory
if [[ -d "$CLAUDE_DIR/skills/gstack" ]]; then
    log_success "gstack skills already installed"
# Check if included in this repo
elif [[ -d "$SCRIPT_DIR/skills/gstack" ]]; then
    ln -sf "$SCRIPT_DIR/skills/gstack" "$CLAUDE_DIR/skills/gstack"
    log_success "gstack skills linked from repo"
# Check if user has it elsewhere
elif [[ -d "$HOME/gstack" ]]; then
    if confirm "Found gstack in $HOME/gstack. Link it?"; then
        ln -sf "$HOME/gstack" "$CLAUDE_DIR/skills/gstack"
        log_success "gstack skills linked from $HOME/gstack"
    fi
else
    log_warning "gstack skills not found"
    echo
    echo "  gstack provides automation skills: /review, /qa, /ship, /browse, /retro"
    echo
    echo "  📥 To install gstack:"
    echo "     See: $SCRIPT_DIR/docs/GSTACK_INSTALL.md"
    echo
    echo "  You can install it later without affecting other optimizations."
    echo
fi

# 8. Install conversation-recorder
log_info "Installing conversation-recorder skill..."
if [[ -d "$SCRIPT_DIR/skills/conversation-recorder" ]]; then
    ln -sf "$SCRIPT_DIR/skills/conversation-recorder" "$CLAUDE_DIR/skills/conversation-recorder"
    log_success "conversation-recorder installed"
else
    log_warning "conversation-recorder skill not found"
    log_info "You can create this skill or link it manually"
fi

# 9. Check for Conductor
log_info "Checking for Conductor (workspace management)..."
if [[ -d "$HOME/Library/Application Support/com.conductor.app" ]]; then
    log_success "Conductor detected"
else
    log_warning "Conductor not detected"
    log_info "Install Conductor for workspace isolation:"
    echo "  Visit: https://conductor.app (if available)"
    echo "  Or search for 'Conductor Claude' in your app store"
fi

# 10. Check for Handy (voice-to-text)
log_info "Checking for Handy (voice-to-text)..."
if [[ -d "/Applications/Handy.app" ]]; then
    log_success "Handy detected - voice-to-text available"
else
    log_warning "Handy not detected"
    log_info "Install Handy for faster input (FREE & open source):"
    echo "  GitHub: https://github.com/handy-app/handy"
    echo "  Website: https://handy.app"
    echo "  Mac App Store: Search 'Handy Voice to Text'"
    echo "  Benefit: 3x faster input, clearer prompts, fewer iterations"
fi

# Summary
echo
echo "╔════════════════════════════════════════════════════════════╗"
echo "║   Setup Complete!                                          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo
log_success "Configuration applied to $CLAUDE_DIR"
echo
echo "📊 Next Steps:"
echo
echo "1. Monitor your costs:"
echo "   ${BLUE}claudetop --today${NC}"
echo
echo "2. Use automation skills:"
echo "   ${BLUE}/review${NC}  - Review PR before landing"
echo "   ${BLUE}/qa${NC}      - Test your application"
echo "   ${BLUE}/ship${NC}    - Complete ship workflow"
echo "   ${BLUE}/browse${NC}  - Test with headless browser"
echo "   ${BLUE}/retro${NC}   - Weekly retrospective"
echo
echo "   ${BLUE}code-review-graph${NC} skills (if installed):"
echo "   ${BLUE}/review-delta${NC} - Review only changes since last commit"
echo "   ${BLUE}/review-pr${NC}    - Review PR with blast-radius analysis"
echo "   ${BLUE}/build-graph${NC}  - Build/update code knowledge graph"
echo
echo "3. (Optional) Install Handy for voice-to-text (FREE & open source):"
echo "   ${BLUE}https://github.com/handy-app/handy${NC}"
echo "   or Mac App Store → Search 'Handy'"
echo "   See docs/VOICE_TO_TEXT.md for setup guide"
echo
echo "4. Create a new Claude session to apply changes"
echo
echo "5. After 1 week, compare costs:"
echo "   ${BLUE}claudetop --days 7 --summary${NC}"
echo
echo "📖 Documentation: $SCRIPT_DIR/README.md"
echo "❓ Questions: $SCRIPT_DIR/FAQ.md"
echo
log_info "Expected result: ~70% cost reduction with enhanced productivity"
echo
