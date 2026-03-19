# Voice-to-Text with Handy

Using voice input can significantly improve your productivity with Claude Code and reduce friction in your workflow.

## Why Voice-to-Text?

### Speed
- Speak 3x faster than typing (150-200 words/min vs 40-60 wpm)
- Less time composing = more time reviewing responses
- Faster iterations lead to better results

### Quality
- Easier to explain complex concepts verbally
- More natural communication style
- Better context in fewer attempts
- Reduces back-and-forth clarifications (saves tokens!)

### Ergonomics
- Reduces typing fatigue
- Better for long sessions
- Can multitask while speaking

## Handy App - Open Source Voice-to-Text

**Handy** is an open-source Mac application for voice-to-text conversion.

### Key Features
- **Open source** - Fully transparent, community-driven
- **Privacy-focused** - Local processing, no cloud required
- **Free** - No subscription fees
- **Lightweight** - Minimal system resources
- **Accurate** - Built on modern speech recognition

### Links
- **GitHub**: https://github.com/handy-app/handy
- **Website**: https://handy.app
- **Mac App Store**: Search for "Handy Voice to Text"
- **Documentation**: https://github.com/handy-app/handy#readme

### Installation

#### Option 1: Mac App Store (Recommended)
```bash
# Search "Handy" in Mac App Store
# or use this direct link if available
open "macappstore://apps.apple.com/app/handy-voice-to-text"
```

#### Option 2: Download from Website
1. Visit https://handy.app
2. Download latest release
3. Drag to Applications folder
4. Grant microphone permissions

#### Option 3: Build from Source
```bash
# Clone the repository
git clone https://github.com/handy-app/handy.git
cd handy

# Install dependencies
npm install

# Build
npm run build

# Run
npm start
```

### Setup

```bash
# Check if Handy is installed
ls /Applications/Handy.app

# Open Handy
open -a Handy

# Grant microphone permissions when prompted
# System Preferences → Security & Privacy → Microphone → Enable Handy
```

### Configuration

1. **Set keyboard shortcut** (recommended: `Cmd+Shift+Space`)
2. **Choose language** (supports 50+ languages)
3. **Enable auto-paste** (optional)
4. **Configure custom vocabulary** for technical terms

### Basic Usage

1. **Activate Handy** with your keyboard shortcut
2. **Speak your prompt** clearly
3. **Text appears** in your active application
4. **Send to Claude Code** directly

### Best Practices

#### For Complex Explanations
```
Good: "I need to implement user authentication using JWT tokens.
The API should accept username and password, validate against
the database, and return a signed token with user ID and email
claims. The token should expire after 24 hours."

vs typing: (takes 3x longer and you might forget details)
```

#### For Code Review Requests
```
Good: "Review this pull request for security issues. Pay special
attention to SQL injection vulnerabilities in the user input
handling, and check if all API endpoints have proper
authentication middleware."
```

#### For Architecture Discussions
```
Good: "I'm deciding between using Redis or in-memory caching
for session storage. The app handles about 10,000 concurrent
users. I need your thoughts on scalability, persistence
requirements, and cost trade-offs."
```

### Integration with Claude Code

#### Workflow
1. **Activate Handy** (keyboard shortcut)
2. **Speak your task** naturally
3. **Review transcription** (edit if needed)
4. **Submit to Claude**
5. **Repeat** for follow-ups

#### Tips
- **Speak in complete thoughts** - avoid fragmented sentences
- **Use punctuation commands** - "comma", "period", "new line"
- **Spell technical terms** - "class UserAuth capital U capital A"
- **Review before sending** - catch transcription errors
- **Edit shortcuts** - fix technical jargon quickly

### Common Voice Commands

```
"period"           → .
"comma"            → ,
"new line"         → \n
"new paragraph"    → \n\n
"quote"            → "
"slash"            → /
"backslash"        → \
"all caps [word]"  → WORD
"no space [word]"  → concatenates
```

### Cost Savings

Voice-to-text helps reduce costs by:

1. **Faster clarification** - explain complex requirements in one go
2. **Fewer iterations** - better initial prompts = fewer follow-ups
3. **Natural language** - more context upfront reduces confusion
4. **Parallel thinking** - speak while formulating next steps

**Example:**
- Typing complex requirement: 5 minutes, 3 clarification rounds
- Speaking complex requirement: 2 minutes, 1 clarification round
- **Savings: 60% time + 66% fewer queries**

### Privacy & Open Source Benefits

#### Why Open Source Matters
- **Transparency** - Audit the code yourself
- **Security** - No hidden data collection
- **Community** - Contribute improvements
- **No vendor lock-in** - Always free to use
- **Customization** - Modify to your needs

#### Handy's Privacy Approach
- **Local processing** - Speech recognition runs on your Mac
- **No cloud required** - Zero data sent to external servers
- **No tracking** - No analytics or telemetry
- **No accounts** - Works without registration

### Contributing to Handy

Since Handy is open source, you can contribute:

```bash
# Fork and clone
git clone https://github.com/handy-app/handy.git
cd handy

# Create feature branch
git checkout -b feature/your-feature

# Make changes, test
npm test

# Submit PR
git push origin feature/your-feature
```

**Popular contributions:**
- Language support
- Custom vocabulary
- Keyboard shortcuts
- UI improvements
- Bug fixes

### Alternatives to Handy

If Handy doesn't work for you:

#### Mac Built-in
```bash
# Enable dictation in System Preferences
# Keyboard → Dictation → Enable
# Use Fn key (press twice) to activate
```

#### Other Open Source Options
- **Whisper Desktop** - Based on OpenAI Whisper
- **Talon Voice** - Voice coding (advanced)
- **Nerd Dictation** - Linux/Mac command-line tool

#### Commercial Options
- **Dragon Dictate** - Professional dictation
- **Mac's Enhanced Dictation** - Offline mode

### Troubleshooting

#### Poor Transcription Quality
- **Check microphone** - Use external mic if possible
- **Reduce background noise** - Find quiet space
- **Speak clearly** - Not too fast, enunciate
- **Train the app** - Use custom vocabulary for technical terms

#### Handy Not Working
```bash
# Check microphone permissions
open "x-apple.systempreferences:com.apple.preference.security?Privacy_Microphone"

# Restart Handy
killall Handy
open -a Handy

# Check GitHub issues
open "https://github.com/handy-app/handy/issues"
```

#### Technical Terms Not Recognized
- **Create custom vocabulary** in Handy settings
- **Spell out** terms first time: "class name UserAuth, U-s-e-r-A-u-t-h"
- **Contribute** to Handy's technical dictionary

### Advanced Usage

#### Code Dictation
```
# Example prompt:
"Create a function called getUserById that takes an ID parameter,
queries the database, and returns the user object or null if not found.
Handle errors with try-catch and log any exceptions."

# Result: Clear requirements without typing code syntax
```

#### Multi-language Support
- Switch language in Handy settings
- Use for translating requirements
- Helpful for international teams

#### Batch Prompts
Record multiple prompts in one session:
```
"First, review the authentication module.
New paragraph.
Second, check the database migrations for any issues.
New paragraph.
Third, run the test suite and report any failures."
```

### Measuring Impact

Track your productivity gains:

**Before voice-to-text:**
- Time per complex prompt: 5-10 minutes
- Clarification rounds: 2-3 per task

**After voice-to-text:**
- Time per complex prompt: 2-3 minutes
- Clarification rounds: 0-1 per task

**Weekly savings:**
- 20 complex prompts/week
- Before: 100-200 minutes typing
- After: 40-60 minutes speaking
- **Savings: 60-140 minutes/week**

Plus token savings from clearer initial prompts!

### Combine with Other Optimizations

Voice-to-text works great with:
- **Conversation recording** - Speak task, save for later
- **Workspace switching** - Quick voice notes per workspace
- **Code review** - Explain findings verbally
- **Documentation** - Dictate docs instead of typing
- **gstack skills** - Voice activate /review, /qa, /ship commands

### ROI Calculation

Example for heavy Claude Code user:

**Monthly costs before optimization:**
- Typing time: 20 hours/month
- Token usage: 1B tokens
- Cost: ~$1,200

**With voice-to-text (Handy):**
- Speaking time: 8 hours/month (60% reduction)
- Token usage: 750M tokens (better prompts = fewer iterations)
- Cost: ~$900
- **Savings: $300/month + 12 hours**

**Handy cost:** FREE (open source!)
**Payback period:** Immediate

### Community & Support

- **GitHub Issues**: https://github.com/handy-app/handy/issues
- **Discussions**: https://github.com/handy-app/handy/discussions
- **Discord**: Check README for community chat link
- **Twitter**: Follow @HandyApp for updates

### Stay Updated

```bash
# Star the repo for updates
open "https://github.com/handy-app/handy"

# Watch releases
# GitHub → Watch → Custom → Releases

# Pull latest version
cd ~/path/to/handy
git pull origin main
npm install
npm run build
```

---

**Pro tip:** Combine Handy with `/review`, `/qa`, and other skills for maximum efficiency. Speak your requirements, let automation handle the execution!

**Open source advantage:** Free forever, privacy-first, community-driven improvements. This is the future of developer tools!
