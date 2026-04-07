import SwiftUI
import Combine

/// Global theme manager - now simplified to exclusively support Dark Mode
class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = true
    
    init() {
        // Force dark mode regardless of stored preferences
        self.isDarkMode = true
    }
}
