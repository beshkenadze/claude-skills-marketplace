# SwiftUI/iOS/macOS Claude Skills Research

**Date**: 2025-12-19
**Confidence**: High (multiple verified sources)

## Executive Summary

The Claude Code ecosystem has a growing collection of Swift/iOS/macOS development skills and tools. The most comprehensive solution is **Axiom** by Charles Wiltgen, with **31 battle-tested skills** specifically for Apple platform development. Several specialized tools also exist for iOS Simulator automation, Swift language reference, and Apple Developer Documentation access.

---

## Top Skills & Plugins

### 1. Axiom (★ Recommended)

**Author**: Charles Wiltgen (@CharlesWiltgen)
**URL**: https://charleswiltgen.github.io/Axiom/
**Type**: Claude Code Plugin with Agent Skills

The most comprehensive iOS/macOS development toolkit:

| Category | Skills |
|----------|--------|
| **UI & Design** | hig, liquid-glass, swiftui-architecture, swiftui-layout, swiftui-navigation, swiftui-performance, swiftui-debugging, swiftui-gestures, uikit-animation-debugging |
| **Debugging** | auto-layout-debugging, deep-link-debugging, xcode-debugging, memory-debugging, build-troubleshooting, build-performance, performance-profiling, objc-block-retain-cycles |
| **Concurrency** | swift-concurrency (Swift 6 actor isolation & data races) |
| **Persistence** | codable, database-migration, sqlitedata, grdb, swiftdata, swiftdata-migration, swiftdata-to-sqlitedata |
| **Integration** | app-intents, extensions-widgets, foundation-models (iOS 26+), in-app-purchases, networking, now-playing |
| **Testing** | ui-testing |

**Quality**: 18 TDD-tested skills, 12 reference skills, 7 diagnostic skills

---

### 2. iOS Simulator Skill

**Author**: Conor Luddy (@conorluddy)
**URL**: https://github.com/conorluddy/ios-simulator-skill
**Type**: Claude Code Skill

21 production-ready scripts for:
- **Build & Development**: Compiling, test execution, real-time logging
- **Navigation**: Accessibility-based element selection (not pixel coords)
- **Testing**: WCAG audits, screenshot comparison, state capture
- **Advanced**: Push notification simulation, permission management
- **Device Lifecycle**: Simulator creation, boot/shutdown, reset

**Key Feature**: 96% token reduction vs raw tools

---

### 3. The Unofficial Swift Programming Language Skill

**Author**: Kyle Hughes (@kylehughes)
**URL**: https://github.com/kylehughes/the-unofficial-swift-programming-language-skill

Complete Swift language reference as a Claude skill:
- Auto-updated nightly from official docs
- Full Swift 5.x/6.x coverage
- MIT licensed

**Installation**:
```bash
/plugin marketplace add kylehughes/the-unofficial-swift-programming-language-skill
/plugin install programming-swift-skill@the-unofficial-swift-programming-language-skill
```

---

### 4. ios-swift-development Skill

**Source**: https://claude-plugins.dev/skills/@aj-geddes/useful-ai-prompts/ios-swift-development

Covers:
- MVVM architecture with @Published/@StateObject
- URLSession + async/await networking
- SwiftUI views with TabView/NavigationLink
- Core Data persistence
- Keychain security best practices

---

### 5. Swift 6 Migration Plugin

**Author**: Ivan Magda (@ivan-magda)
**URL**: https://github.com/ivan-magda/claude-code-marketplace

Features:
- Swift 6 concurrency migration guidance
- Data race safety detection
- Sendable conformance support
- Complete checking mode implementation

**Installation**:
```bash
/plugin marketplace add ivan-magda/claude-code-marketplace
/plugin install swift@claude-code-marketplace
```

---

## MCP Servers

### Apple Developer Documentation MCP

**Author**: Kim Sungwhee (@kimsungwhee)
**URL**: https://github.com/kimsungwhee/apple-docs-mcp

14 specialized tools for:
- Apple Developer Documentation search
- WWDC 2014-2025 sessions (1,260+ videos with transcripts)
- SwiftUI, UIKit, Metal, Core ML, Vision, ARKit docs
- iOS 13+, macOS 10.15+, watchOS 6+, tvOS 13+, visionOS compatibility

**Installation for Claude Code**:
```bash
claude mcp add apple-docs -- npx -y @kimsungwhee/apple-docs-mcp@latest
```

---

## Official Integration: Claude in Xcode 26

As of September 2025, Claude Sonnet 4 is natively integrated into Xcode 26:
- Natural language coding assistant
- SwiftUI preview generation
- Documentation generation
- Inline code changes
- Context gathering from project files

**Requirements**: M1+ Mac, macOS 26 Tahoe

---

## Quick Installation Summary

| Tool | Installation Command |
|------|---------------------|
| Axiom | `/plugin marketplace add CharlesWiltgen/Axiom` |
| iOS Simulator | `/plugin marketplace add conorluddy/ios-simulator-skill` |
| Swift Language | `/plugin marketplace add kylehughes/the-unofficial-swift-programming-language-skill` |
| Swift 6 Migration | `/plugin marketplace add ivan-magda/claude-code-marketplace` |
| Apple Docs MCP | `claude mcp add apple-docs -- npx -y @kimsungwhee/apple-docs-mcp@latest` |

---

## Known Limitations

Claude Code with Swift/iOS:
- Best with Swift 5.5 and earlier features
- May confuse modern APIs with legacy Objective-C equivalents
- Sometimes uses AppKit/UIKit when SwiftUI would be better
- No clean workflow for iterating on UI with iOS Simulator previews yet

---

## Sources

- [Axiom by CharlesWiltgen](https://charleswiltgen.github.io/Axiom/)
- [iOS Simulator Skill](https://github.com/conorluddy/ios-simulator-skill)
- [Swift Programming Language Skill](https://github.com/kylehughes/the-unofficial-swift-programming-language-skill)
- [Apple Docs MCP](https://github.com/kimsungwhee/apple-docs-mcp)
- [ivan-magda/claude-code-marketplace](https://github.com/ivan-magda/claude-code-marketplace)
- [Claude in Xcode - Anthropic](https://www.anthropic.com/news/claude-in-xcode)
- [ios-swift-development skill](https://claude-plugins.dev/skills/@aj-geddes/useful-ai-prompts/ios-swift-development)
- [I Shipped a macOS App Built Entirely by Claude Code](https://www.indragie.com/blog/i-shipped-a-macos-app-built-entirely-by-claude-code)
- [Rewriting a 12 Year Old Objective-C iOS App with Claude Code](https://twocentstudios.com/2025/06/22/vinylogue-swift-rewrite/)
