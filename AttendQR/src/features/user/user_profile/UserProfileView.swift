import SwiftUI
import Combine

struct UserProfileView: View {
    @StateObject private var viewModel = UserProfileViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            AppColors.adaptiveBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // Profile Header
                    profileHeader
                    
                    // Quick Stats
                    statsSelector
                    
                    // Settings Groups
                    VStack(spacing: 24) {
                        ForEach(0..<viewModel.settingsGroups.count, id: \.self) { groupIndex in
                            VStack(spacing: 0) {
                                ForEach(viewModel.settingsGroups[groupIndex]) { item in
                                    SettingsRow(item: item)
                                    
                                    if item.id != viewModel.settingsGroups[groupIndex].last?.id {
                                        Divider()
                                            .background(Color.white.opacity(0.05))
                                            .padding(.leading, 56)
                                    }
                                }
                            }
                            .background(AppColors.cardDark)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Logout Button
                    Button(action: {
                        router.navigate(to: .login)
                    }) {
                        HStack {
                            Image(systemName: "power")
                                .font(.system(size: 18, weight: .bold))
                            Text("Sign Out")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 120)
                }
                .padding(.top, 40)
            }
        }
    }
    
    private var profileHeader: some View {
        VStack(spacing: 16) {
            // Profile Picture with Teal Glow
            ZStack {
                Circle()
                    .fill(AppColors.accent.opacity(0.15))
                    .frame(width: 120, height: 120)
                    .blur(radius: 20)
                
                Circle()
                    .stroke(AppColors.accent, lineWidth: 2)
                    .frame(width: 100, height: 100)
                
                Image(systemName: "person.fill")
                    .resizable()
                    .padding(25)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.05))
                    .clipShape(Circle())
            }
            
            VStack(spacing: 4) {
                CustomText(
                    title: viewModel.userName,
                    fontSize: 24,
                    fontColor: .white,
                    weight: .bold
                )
                
                CustomText(
                    title: "Status: \(viewModel.status)",
                    fontSize: 14,
                    fontColor: AppColors.accent,
                    weight: .medium
                )
            }
        }
    }
    
    private var statsSelector: some View {
        HStack(spacing: 16) {
            CompactStatCard(title: "Attendance", value: "\(viewModel.attendanceRate)%", icon: "chart.bar.fill")
            CompactStatCard(title: "Points", value: "\(viewModel.points)", icon: "star.fill")
        }
        .padding(.horizontal, 24)
    }
}

// MARK: - Subviews
struct CompactStatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppColors.accent.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(AppColors.accent)
                    .font(.system(size: 16))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(AppColors.textTertiary)
                Text(value)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding(12)
        .background(AppColors.cardDark)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}

struct SettingsRow: View {
    let item: SettingsItem
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(item.color.opacity(0.1))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: item.icon)
                        .foregroundColor(item.color)
                        .font(.system(size: 18))
                }
                
                Text(item.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                if let detail = item.detail {
                    Text(detail)
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.textTertiary)
                }
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppColors.textTertiary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    UserProfileView()
        .environmentObject(ThemeManager())
        .environmentObject(Router())
}
