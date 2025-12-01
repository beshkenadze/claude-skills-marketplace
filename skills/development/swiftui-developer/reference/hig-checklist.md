# Apple Human Interface Guidelines Checklist

## Touch & Interaction

- [ ] Interactive elements are at least 44×44 points
- [ ] Adequate spacing between tap targets (8pt minimum)
- [ ] Buttons have visible feedback states
- [ ] Swipe actions are discoverable

## Typography

- [ ] Body text is at least 17pt
- [ ] Headlines are at least 34pt
- [ ] Dynamic Type is supported (use `.font(.body)`, `.font(.headline)`)
- [ ] Text truncation handled gracefully
- [ ] Line height allows comfortable reading

## Color & Contrast

- [ ] Color contrast ratio is at least 4.5:1
- [ ] Using semantic colors (`.primary`, `.secondary`, `.accent`)
- [ ] Not relying solely on color to convey information
- [ ] Dark mode is fully supported
- [ ] System appearance changes handled

## Layout & Adaptability

- [ ] Works in both portrait and landscape
- [ ] Adapts to different screen sizes (iPhone, iPad)
- [ ] Safe areas respected
- [ ] Keyboard doesn't obscure content
- [ ] Content readable at all Dynamic Type sizes

## Navigation

- [ ] Navigation hierarchy is clear (max 3-4 levels)
- [ ] Back navigation is always available
- [ ] Current location is obvious
- [ ] Tab bar items are ≤5
- [ ] Icons are recognizable with labels

## Accessibility

### VoiceOver

- [ ] All images have `.accessibilityLabel`
- [ ] Buttons have descriptive labels
- [ ] Groups use `.accessibilityElement(children: .combine)`
- [ ] Reading order is logical
- [ ] Custom actions where appropriate

### Motor

- [ ] Large touch targets (44×44pt)
- [ ] No time-sensitive interactions (or adjustable)
- [ ] Alternative input methods supported
- [ ] No precision-required gestures as only option

### Visual

- [ ] Dynamic Type supported
- [ ] Bold Text setting respected
- [ ] Reduce Motion setting honored
- [ ] Sufficient contrast
- [ ] Not relying on color alone

### Code Examples

```swift
// Good accessibility
Image(systemName: "star.fill")
    .accessibilityLabel("Favorite")
    .accessibilityHint("Double tap to add to favorites")

Button(action: save) {
    Label("Save", systemImage: "square.and.arrow.down")
}
.accessibilityLabel("Save document")

// Grouping related elements
VStack {
    Text(item.title)
    Text(item.subtitle)
}
.accessibilityElement(children: .combine)
```

## Forms & Input

- [ ] Labels clearly describe fields
- [ ] Error messages are specific and helpful
- [ ] Required fields are marked
- [ ] Appropriate keyboard types used
- [ ] Autocomplete/autofill supported where relevant

## Feedback & States

- [ ] Loading states are visible
- [ ] Empty states provide guidance
- [ ] Error states explain how to recover
- [ ] Success states confirm completion
- [ ] Haptic feedback for significant actions

## iOS 18+ Specific

- [ ] App icon has light/dark/tinted variants
- [ ] Widgets support accented appearance
- [ ] Control Center controls are appropriately sized
- [ ] Lock Screen widgets are useful at a glance

## Common SwiftUI Patterns

### Semantic Colors

```swift
Text("Title")
    .foregroundStyle(.primary)

Text("Subtitle")
    .foregroundStyle(.secondary)

Button("Action") { }
    .tint(.accentColor)
```

### Dynamic Type

```swift
Text("Body text")
    .font(.body)

Text("Title")
    .font(.title)

// Custom font with scaling
Text("Custom")
    .font(.custom("MyFont", size: 17, relativeTo: .body))
```

### Respecting Reduce Motion

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

var animation: Animation? {
    reduceMotion ? nil : .spring()
}
```

### Dark Mode Support

```swift
// Automatic with semantic colors
Color.primary  // Adapts automatically
Color.secondary
Color.accentColor

// Custom colors
Color("MyColor")  // Define in asset catalog for both modes

// Detecting mode
@Environment(\.colorScheme) var colorScheme
```

## Quick Validation

Before shipping, verify:

1. **Run Accessibility Inspector** in Xcode
2. **Test with VoiceOver** enabled
3. **Test with larger Dynamic Type** sizes
4. **Test in Dark Mode**
5. **Test on smallest supported device**
6. **Test with Reduce Motion** enabled
