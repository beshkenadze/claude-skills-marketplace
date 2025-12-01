# SwiftUI State Management Reference

## Property Wrapper Decision Tree

```
Is the data owned by this view?
├── YES: Is it a simple value type?
│   ├── YES → @State
│   └── NO: Is it an @Observable class?
│       ├── YES (iOS 17+) → @State
│       └── NO (ObservableObject) → @StateObject
└── NO: Is it passed from parent?
    ├── YES: Need two-way binding?
    │   ├── YES → @Binding
    │   └── NO → Regular parameter
    └── NO: Is it app-wide shared data?
        ├── YES (iOS 17+) → @Environment
        └── YES (legacy) → @EnvironmentObject
```

## Quick Reference

| Wrapper | Owner | Mutability | Use Case |
|---------|-------|------------|----------|
| `@State` | View | Read/Write | Local value types, @Observable objects |
| `@Binding` | Parent | Read/Write | Two-way data from parent |
| `@StateObject` | View | Read/Write | ObservableObject created by view |
| `@ObservedObject` | External | Read | ObservableObject passed in |
| `@EnvironmentObject` | App | Read | Shared ObservableObject |
| `@Environment` | System/App | Read | System values, @Observable shared data |

## iOS 17+ Migration

### Before (ObservableObject)

```swift
class UserViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
}

struct ProfileView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        TextField("Name", text: $viewModel.name)
    }
}
```

### After (@Observable)

```swift
import Observation

@Observable
class UserViewModel {
    var name: String = ""
    var email: String = ""
}

struct ProfileView: View {
    @State private var viewModel = UserViewModel()

    var body: some View {
        TextField("Name", text: $viewModel.name)
    }
}
```

## @Observable Benefits

1. **Granular updates**: Only properties accessed in `body` trigger redraws
2. **No @Published needed**: All properties automatically observed
3. **Works with optionals**: Can track optional and collection changes
4. **Simpler API**: Use `@State` instead of `@StateObject`

## @ObservationIgnored

Exclude properties from observation:

```swift
@Observable
class DataManager {
    var items: [Item] = []           // Observed
    @ObservationIgnored var cache: [String: Data] = [:]  // Not observed
}
```

## Environment Sharing (iOS 17+)

```swift
// Define observable
@Observable
class AppSettings {
    var theme: Theme = .system
    var language: Language = .english
}

// Inject at root
@main
struct MyApp: App {
    @State private var settings = AppSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(settings)
        }
    }
}

// Access in any view
struct SettingsView: View {
    @Environment(AppSettings.self) private var settings

    var body: some View {
        Picker("Theme", selection: $settings.theme) { ... }
    }
}
```

## Common Mistakes

### 1. @State with Reference Types

```swift
// BAD - causes memory leaks
@State private var viewModel = SomeClass()

// GOOD (legacy)
@StateObject private var viewModel = SomeClass()

// GOOD (iOS 17+ with @Observable)
@State private var viewModel = SomeObservableClass()
```

### 2. Creating ObservedObject in View

```swift
// BAD - recreated every render
@ObservedObject var viewModel = ViewModel()

// GOOD - persists across renders
@StateObject var viewModel = ViewModel()
```

### 3. Excessive State

```swift
// BAD - too much state in view
@State private var items: [Item] = []
@State private var isLoading = false
@State private var error: Error?
@State private var selectedItem: Item?

// GOOD - encapsulated in ViewModel
@State private var viewModel = ItemsViewModel()
```

## Performance Tips

1. **Keep state local**: Don't lift state higher than needed
2. **Extract subviews**: Isolate state changes to smaller views
3. **Use computed properties**: Derive values instead of storing duplicates
4. **Debounce updates**: For rapid changes (search fields)

```swift
@Observable
class SearchViewModel {
    var searchText: String = "" {
        didSet {
            searchTask?.cancel()
            searchTask = Task {
                try? await Task.sleep(for: .milliseconds(300))
                await performSearch()
            }
        }
    }
    private var searchTask: Task<Void, Never>?
}
```
