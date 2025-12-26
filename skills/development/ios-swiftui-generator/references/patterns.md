# SwiftUI Component Patterns

## Navigation Patterns

### Tab Bar
```swift
struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}
```

### Navigation Stack
```swift
struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink(value: item) {
                    ItemRow(item: item)
                }
            }
            .navigationTitle("Items")
            .navigationDestination(for: Item.self) { item in
                ItemDetailView(item: item)
            }
        }
    }
}
```

## Form Patterns

### Settings Form
```swift
struct SettingsView: View {
    @AppStorage("notifications") private var notifications = true
    @AppStorage("darkMode") private var darkMode = false

    var body: some View {
        Form {
            Section("Preferences") {
                Toggle("Notifications", isOn: $notifications)
                Toggle("Dark Mode", isOn: $darkMode)
            }

            Section("Account") {
                NavigationLink("Profile") {
                    ProfileView()
                }
                NavigationLink("Privacy") {
                    PrivacyView()
                }
            }
        }
        .navigationTitle("Settings")
    }
}
```

### Input Form with Validation
```swift
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isValid = false

    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .textContentType(.password)
            }

            Section {
                Button("Sign In") {
                    signIn()
                }
                .disabled(!isValid)
            }
        }
        .onChange(of: email) { validateForm() }
        .onChange(of: password) { validateForm() }
    }
}
```

## List Patterns

### List with Swipe Actions
```swift
struct ItemListView: View {
    @State private var items: [Item] = []

    var body: some View {
        List {
            ForEach(items) { item in
                ItemRow(item: item)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            delete(item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            toggleFavorite(item)
                        } label: {
                            Label("Favorite", systemImage: "star")
                        }
                        .tint(.yellow)
                    }
            }
        }
        .refreshable {
            await loadItems()
        }
    }
}
```

### Empty State
```swift
struct ContentView: View {
    let items: [Item]

    var body: some View {
        Group {
            if items.isEmpty {
                ContentUnavailableView(
                    "No Items",
                    systemImage: "tray",
                    description: Text("Add items to get started")
                )
            } else {
                List(items) { item in
                    ItemRow(item: item)
                }
            }
        }
    }
}
```

## Card Patterns

### Info Card
```swift
struct InfoCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.blue)
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
```

## Accessibility Patterns

### Accessible Button
```swift
Button {
    performAction()
} label: {
    Image(systemName: "plus")
}
.accessibilityLabel("Add new item")
.accessibilityHint("Double tap to create a new item")
```

### Combined Accessibility
```swift
HStack {
    Image(systemName: "star.fill")
        .accessibilityHidden(true)
    Text("5.0")
    Text("(128 reviews)")
        .foregroundStyle(.secondary)
}
.accessibilityElement(children: .combine)
.accessibilityLabel("Rating 5.0, 128 reviews")
```

## Color Patterns

### Semantic Colors
```swift
// Backgrounds
Color(.systemBackground)           // Primary background
Color(.secondarySystemBackground)  // Grouped/card background
Color(.tertiarySystemBackground)   // Nested elements

// Labels
Color.primary                      // Primary text
Color.secondary                    // Secondary text
Color(.tertiaryLabel)              // Disabled/hint text

// Fills
Color(.systemFill)                 // Thin overlay
Color(.secondarySystemFill)        // Medium overlay
Color(.tertiarySystemFill)         // Thick overlay
```
