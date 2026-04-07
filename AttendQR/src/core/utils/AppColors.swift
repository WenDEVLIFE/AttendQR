import SwiftUI

/// Color utility class with your blue palette
/// Colors from darkest to lightest:
/// 03045E → 023E8A → 0077B6 → 0096C7 → 00B4D8 → 48CAE4 → 90E0EF → ADE8F4 → CAF0F8
struct AppColors {
    // Primary Blue Palette (Darkest to Lightest)
    static let blue900 = Color(hex: "03045E") // Darkest - Primary Dark
    static let blue800 = Color(hex: "023E8A") // Primary
    static let blue700 = Color(hex: "0077B6") // Primary Variant
    static let blue600 = Color(hex: "0096C7") // Secondary
    static let blue500 = Color(hex: "00B4D8") // Secondary Variant
    static let blue400 = Color(hex: "48CAE4") // Tertiary
    static let blue300 = Color(hex: "90E0EF") // Tertiary Variant
    static let blue200 = Color(hex: "ADE8F4") // Surface Light
    static let blue100 = Color(hex: "CAF0F8") // Background Lightest

    // Semantic Colors (Using Assets)
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let accent = Color("Accent")
    
    // Zinc Shades
    static let zinc400 = Color("Zinc400")
    static let zinc500 = Color("Zinc500")
    static let zinc950 = Color(hex: "09090B") // Premium dark

    // Background Colors
    static let background = zinc950
    static let surface = Color(hex: "18181B") // zinc-900 equivalent
    
    // Text Colors
    static let textPrimary = Color.white
    static let textSecondary = zinc400
    static let textTertiary = zinc500
    static let textOnPrimary = Color.white

    // Status Colors
    static let success = Color(hex: "10B981")
    static let error = Color(hex: "EF4444")
    static let warning = Color(hex: "F59E0B")
    static let info = secondary

    // Border & Divider
    static let border = Color.white.opacity(0.1)
    static let divider = Color.white.opacity(0.1)

    // Shadow & Overlay
    static let shadow = Color.black.opacity(0.3)
    static let overlay = Color.black.opacity(0.7)

    /// Unified dark background color
    static let loginDark = zinc950

    /// Dark blue color for cards and components in dark mode
    static let cardDark = Color(hex: "18181B") // Consistent with zinc-900

    /// Unified background view for Dark Mode
    @ViewBuilder
    static func adaptiveBackground(isDarkMode: Bool = true) -> some View {
        loginDark.ignoresSafeArea()
    }

    /// Eye-friendly solid background color
    static let softBackground = zinc950
}

/// Legacy ColorUtils for backward compatibility
struct ColorUtils {
    static let primaryColor = AppColors.primary
    static let secondaryColor = AppColors.secondary
    static let backgroundColor = AppColors.background
    static let textColor = AppColors.textPrimary
}
