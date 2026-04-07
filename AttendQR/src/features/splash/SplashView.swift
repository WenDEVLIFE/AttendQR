import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var router: Router
    
    // Theme Colors (Now using AppColors)
    let appicon = Image("Logo")
    
    var body: some View {
        ZStack {
            // Premium Modern Dark Background
            AppColors.adaptiveBackground()
            
            // Subtle Radial Glow from Top using Primary and Secondary
            RadialGradient(
                gradient: Gradient(colors: [AppColors.primary.opacity(0.15), .clear]),
                center: .top,
                startRadius: 50,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                // App Icon / Logo Container with Glassmorphism
                ZStack {
                    // Glassy backing
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color.white.opacity(0.05))
                        .frame(width: 210, height: 200)
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark) // Force dark appearance for glassmorphism
                        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                        .overlay(
                            // Translucent border using Zinc500
                            RoundedRectangle(cornerRadius: 32, style: .continuous)
                                .stroke(AppColors.zinc500.opacity(0.3), lineWidth: 1)
                        )
                    
                    // Custom App Logo
                    appicon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190, height: 190)
                        .shadow(color: AppColors.primary.opacity(0.5), radius: 10, x: 0, y: 0)
                }
                .scaleEffect(viewModel.scale)
                .opacity(viewModel.opacity)
                
                // Title with Gradient
                VStack(spacing: 8) {
                    Text("AttendQR")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, .white.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    // Subtitle
                    Text("Smart Attendance System")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(AppColors.zinc400)
                }
                .scaleEffect(viewModel.scale)
                .opacity(viewModel.opacity)
                
                Spacer()
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onChange(of: viewModel.isActive) { newValue in
            if newValue {
                router.navigate(to: .login)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
static var previews: some View {
SplashView()
.environmentObject(ThemeManager())
}
}

