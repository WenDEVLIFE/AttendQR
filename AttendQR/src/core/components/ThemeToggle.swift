import SwiftUI

/// A reusable theme toggle button component
struct ThemeToggle: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let lightIcon: String
    let darkIcon: String
    let iconSize: CGFloat
    let iconColor: Color?
    let padding: EdgeInsets
    let tooltip: String?

    init(
        lightIcon: String = "sun.max.fill",
        darkIcon: String = "moon.fill",
        iconSize: CGFloat = 24,
        iconColor: Color? = nil,
        padding: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8),
        tooltip: String? = nil
    ) {
        self.lightIcon = lightIcon
        self.darkIcon = darkIcon
        self.iconSize = iconSize
        self.iconColor = iconColor
        self.padding = padding
        self.tooltip = tooltip
    }

    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                themeManager.toggleTheme()
            }
        }) {
            Image(systemName: themeManager.isDarkMode ? lightIcon : darkIcon)
                .font(.system(size: iconSize))
                .foregroundColor(iconColor ?? (themeManager.isDarkMode ? .yellow : .blue))
                .padding(padding)
        }
        .help(tooltip ?? (themeManager.isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode"))
    }
}

// MARK: - Preview
struct ThemeToggle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThemeToggle()
                .previewDisplayName("Light Mode")
                .preferredColorScheme(.light)
            
            ThemeToggle()
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
        .environmentObject(ThemeManager())
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
