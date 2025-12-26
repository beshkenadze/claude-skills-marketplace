# Detailed Apple HIG Guidelines

## Materials & Depth (iOS 26+)

### Material Hierarchy

| Level | Thickness | Usage |
|-------|-----------|-------|
| Ultra-thin | Lightest | Subtle overlays |
| Thin | Light | Secondary surfaces |
| Regular | Standard | Primary surfaces |
| Thick | Heavy | Prominent elements |

### Liquid Glass (iOS 26+)
New material system for controls:
- Regular variant: Standard interactive elements
- Clear variant: Minimal visual presence
- Functional layer between content and chrome

### Vibrancy
- Maintains contrast regardless of background
- Automatic in system components
- Use for text over blurred backgrounds

## Shapes & Geometry

### Corner Radius Standards

| Component | Radius |
|-----------|--------|
| Cards | 12-16pt |
| Buttons | 8-12pt |
| Text fields | 8pt |
| Large containers | 20pt |
| Full-width | 0pt (edges) |

### Concentricity Principle
Nested shapes should have aligned corner radii:
```
Outer container: 16pt radius
Inner card: 12pt radius (maintains visual harmony)
```

## Navigation Patterns

### Hierarchical Navigation
- Drill-down from general to specific
- Back button for returning
- Breadcrumb implicit in navigation stack

### Flat Navigation
- Tab bar for equal-weight destinations
- No hierarchy between tabs
- Each tab maintains its own navigation state

### Content-Driven Navigation
- Content determines navigation
- Examples: media players, games
- Gestures drive exploration

## Form Design

### Field Organization
1. Group related fields
2. Use section headers
3. Required fields first
4. Optional fields clearly marked

### Validation
- Inline validation preferred
- Show errors near field
- Clear error states
- Explain how to fix

### Keyboard Handling
- Appropriate keyboard type
- Return key action matches context
- Keyboard avoidance for scroll views

## Error Handling

### Alerts
- Title: What happened
- Message: Brief explanation
- Actions: Clear, actionable buttons
- Default action on right

### Empty States
- Explain why empty
- Guide user to action
- Use illustration sparingly
- Clear call-to-action

### Loading States
- System spinner for brief waits
- Progress bar for determinate
- Skeleton views for content loading

## Gestures

### System Gestures (Do Not Override)
- Edge swipe: Back navigation
- Bottom swipe: Home/app switcher
- Top swipe: Control Center/notifications

### App Gestures
- Tap: Primary action
- Long press: Context menu
- Swipe: Quick actions
- Pinch: Zoom
- Rotate: Rotation

## Animation Guidelines

### Timing
- Quick transitions: 0.2-0.3s
- Standard animations: 0.3-0.5s
- Complex sequences: 0.5-1.0s

### Easing
- Default: ease-in-out
- Enter: ease-out
- Exit: ease-in
- Spring: natural motion

### Reduce Motion
Always respect `UIAccessibility.isReduceMotionEnabled`:
- Replace animations with fades
- Reduce parallax effects
- Simplify transitions

## Platform Considerations

### iPhone
- Portrait primary
- Reachability consideration
- Bottom actions for one-hand use
- Face ID/Touch ID placement

### iPad
- Sidebar navigation
- Split view support
- Keyboard shortcuts
- Pointer/trackpad support

### Multitasking
- Support slide over
- Support split view
- Adapt to size classes
- Handle state restoration

## App Store Guidelines Impact

### Design Requirements
- Must follow HIG for approval
- Native components preferred
- Consistent with platform
- No misleading UI

### Common Rejections
- Non-standard navigation
- Poor accessibility
- Broken dark mode
- Small touch targets
