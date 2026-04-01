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

    // Semantic Colors
    static let primary = blue800 // 023E8A - Main brand color
    static let primaryDark = blue900 // 03045E - Dark mode primary
    static let primaryLight = blue600 // 0096C7 - Light variant
    static let secondary = blue500 // 00B4D8 - Secondary actions
    static let accent = blue400 // 48CAE4 - Accent/highlight

    // Background Colors
    static let background = Color.white
    static let backgroundLight = blue100 // CAF0F8
    static let surface = Color.white
    static let surfaceLight = blue200 // ADE8F4

    // Text Colors
    static let textPrimary = Color(hex: "1A1A1A")
    static let textSecondary = Color(hex: "666666")
    static let textTertiary = Color(hex: "999999")
    static let textOnPrimary = Color.white
    static let textOnDark = Color.white

    // Status Colors
    static let success = Color(hex: "10B981")
    static let error = Color(hex: "EF4444")
    static let warning = Color(hex: "F59E0B")
    static let info = blue500 // 00B4D8

    // Border & Divider
    static let border = Color(hex: "E5E7EB")
    static let divider = Color(hex: "E5E7EB")

    // Shadow & Overlay
    static let shadow = Color.black.opacity(0.1)
    static let overlay = Color.black.opacity(0.5)

    /// Get color by shade (0-8, where 0 is darkest and 8 is lightest)
    static func getShade(_ shade: Int) -> Color {
        switch shade {
        case 0: return blue900
        case 1: return blue800
        case 2: return blue700
        case 3: return blue600
        case 4: return blue500
        case 5: return blue400
        case 6: return blue300
        case 7: return blue200
        case 8: return blue100
        default: return primary
        }
    }

    /// Get gradient from dark to light
    static var primaryGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [blue800, blue500, blue300]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    /// Get gradient for backgrounds
    static var backgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [blue100, .white]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    /// Eye-friendly soft background gradient (softer, less bright) - Light mode
    static var softBackgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color(hex: "F5F7FA"), Color(hex: "F8FAFC")]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    /// Dark mode background gradient
    static var darkBackgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [blue900, blue800]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    /// Unified dark background color (matches login)
    static let loginDark = Color("DarkColor")

    /// Dark blue color for cards and components in dark mode
    static let cardDark = Color(hex: "024889")

    /// Multi-theme background view
    @ViewBuilder
    static func adaptiveBackground(isDarkMode: Bool) -> some View {
        if isDarkMode {
            loginDark.ignoresSafeArea()
        } else {
            backgroundGradient.ignoresSafeArea()
        }
    }

    /// Eye-friendly solid background color
    static let softBackground = Color(hex: "F5F7FA") // Soft gray-blue
}

/// Legacy ColorUtils for backward compatibility
struct ColorUtils {
    static let primaryColor = AppColors.primary
    static let secondaryColor = AppColors.secondary
    static let backgroundColor = AppColors.background
    static let textColor = AppColors.textPrimary
}
