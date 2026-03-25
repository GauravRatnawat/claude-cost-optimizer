# Changelog

All notable changes to the Claude Cost Optimizer project.

## [1.0.0] - 2026-03-19

### Initial Release

Complete setup system for optimizing Claude Code costs.

#### Features
- Automated setup script with interactive mode
- opusplan model configuration
- claudetop cost monitoring
- GitNexus intelligent navigation
- Handy voice-to-text integration
- Conversation recording
- Pre-authorized safe commands
- Comprehensive documentation

#### Documentation
- README.md - Main documentation
- QUICKSTART.md - 5-minute setup guide
- FAQ.md - Common questions
- MANUAL_SETUP.md - Step-by-step guide
- CONTRIBUTING.md - Contribution guidelines
- docs/ALL_COMMANDS.md - Complete command reference for all tools
- docs/VOICE_TO_TEXT.md - Handy voice-to-text guide
- docs/GSTACK_INSTALL.md - gstack installation options
- docs/CREATING_SKILLS.md - Custom skill creation guide

#### Configuration Templates
- templates/CLAUDE.md - Global instructions
- templates/settings.json - Model configuration
- templates/settings.local.json - Permission presets
- templates/hooks.json - GitNexus integration

### Tool Attribution

All third-party tools properly attributed with GitHub links:
- **claudetop**: https://github.com/GauravRatnawat/claudetop (by Gaurav Ratnawat)
- **GitNexus**: https://github.com/abhigyanpatwari/GitNexus (by Abhigyan Patwari)
- **gstack**: https://github.com/garrytan/gstack (by Garry Tan)
- **Handy**: https://github.com/handy-app/handy (open source)
- **GitHub Copilot**: https://github.com/features/copilot (by GitHub)

### Code Review Fixes (2026-03-19)

#### Critical Issues Resolved

**#1: Git Repository Initialization**
- Status: Ready for initialization
- Action required: User to run `git init && git commit`

**#2: Placeholder URLs**
- Status: ✅ Fixed
- Changed: Updated README to clarify repo URL needed after publishing

**#3: Missing gstack Skills**
- Status: ✅ Fixed
- Added: Intelligent detection in setup.sh
- Added: docs/GSTACK_INSTALL.md with installation options
- Added: docs/CREATING_SKILLS.md for custom skills
- Changed: Made gstack optional with clear messaging
- Changed: Setup continues successfully without gstack

#### Medium Priority Issues Resolved

**#4: Handy GitHub URL**
- Status: ✅ Fixed
- Added: Actual open-source Handy links
- Added: Comprehensive voice-to-text documentation

**#5: npm Installation Verification**
- Status: ✅ Fixed
- Added: Proper error handling for npm installs
- Added: Installation verification
- Added: Version checking
- Added: Graceful degradation on failure
- Changed: Script continues on optional tool failure

**#6: Shebang Validation**
- Status: ✅ Fixed
- Added: Bash version check (requires 4+)
- Added: Clear error message with upgrade instructions

#### Enhancements

**Error Handling**
- All npm installs now verify success
- JSON configuration files validated (if jq available)
- File copy operations check for errors
- Graceful degradation when optional tools fail
- Clear error messages with remediation steps

**User Experience**
- Better progress indicators
- Version information displayed
- Helpful tips for missing tools
- Warnings vs errors clearly distinguished
- Installation paths shown for verification

**Documentation**
- Comprehensive gstack installation guide
- Custom skill creation tutorial
- Voice-to-text setup and usage
- Open-source tool links verified
- Privacy and security information added

**Code Quality**
- Bash syntax validated
- Version checking
- Input validation
- Better function organization
- Consistent error handling patterns

### Testing

**Validation performed:**
- ✅ Bash syntax check passed
- ✅ JSON templates valid
- ✅ File structure verified
- ✅ Documentation links checked

**Manual testing required:**
- [ ] Run setup.sh on clean system
- [ ] Verify npm installations
- [ ] Test interactive mode
- [ ] Verify backup creation
- [ ] Test skill installation

### Known Limitations

1. **gstack availability**: May not be publicly available yet
   - Mitigation: Comprehensive installation guide provided
   - Alternative: Custom skill creation documented

2. **Platform support**: Optimized for macOS
   - Windows users: Use WSL or Git Bash
   - Linux users: Should work without modification

3. **npm package availability**: Assumes claudetop and GitNexus are available
   - Mitigation: Graceful failure with manual installation instructions

### Upgrade Instructions

For users of pre-release versions:

```bash
# Backup current config
cp -r ~/.claude ~/.claude.backup.$(date +%Y%m%d)

# Pull latest
cd claude-cost-optimizer
git pull

# Re-run setup
./setup.sh
```

### Breaking Changes

None (initial release)

### Deprecations

None (initial release)

### Security

- All pre-authorized commands are read-only or safe operations
- No credentials stored
- Local processing emphasized
- External tool execution limited and documented

### Contributors

- Initial development and optimization research
- Documentation and testing

---

## Future Releases

### Planned for 2.0.0
- [ ] Automated testing suite
- [ ] Multi-platform installer
- [ ] Cost analytics dashboard
- [ ] Team collaboration features
- [ ] Integration with CI/CD

### Under Consideration
- [ ] Docker container setup
- [ ] Cloud sync for configurations
- [ ] Custom plugin marketplace
- [ ] Advanced cost forecasting
- [ ] Team cost allocation

---

**Note**: Version numbers follow [Semantic Versioning](https://semver.org/).
