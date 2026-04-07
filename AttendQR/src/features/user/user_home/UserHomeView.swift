import SwiftUI

struct UserHomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var router: Router
     
    var body: some View {
        ZStack {
            AppColors.adaptiveBackground()
            
            VStack(spacing: 24) {
                // Top Bar
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        CustomText(
                            title: "Welcome Back,",
                            fontSize: 16,
                            fontColor: AppColors.textTertiary,
                            weight: .medium
                        )
                        CustomText(
                            title: "AttendQR User",
                            fontSize: 24,
                            fontColor: .white,
                            weight: .bold
                        )
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                // Stat Cards (Placeholder)
                HStack(spacing: 16) {
                    StatCard(
                        title: "Events",
                        value: "12",
                        percentageChange: 12.5,
                        icon: UIImage(systemName: "calendar") ?? UIImage(),
                        iconColor: .blue
                    )
                    StatCard(
                        title: "Attended",
                        value: "08",
                        percentageChange: -2.4,
                        icon: UIImage(systemName: "checkmark.circle") ?? UIImage(),
                        iconColor: .green
                    )
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Temporary Logout for Testing
                CustomButton(label: "Sign Out", onPressed: {
                    router.navigate(to: .login)
                })
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    UserHomeView()
        .environmentObject(ThemeManager())
        .environmentObject(Router())
}
