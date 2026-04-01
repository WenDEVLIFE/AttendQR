import SwiftUI
import Combine

/// Global theme manager to handle app-wide theme state and persistence
class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    init() {
        // Load the initial value from UserDefaults
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    /// Toggle between light and dark mode
    func toggleTheme() {
        isDarkMode.toggle()
    }
    
    /// Set a specific theme mode
    func setTheme(isDark: Bool) {
        isDarkMode = isDark
    }
}
