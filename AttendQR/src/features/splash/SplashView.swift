import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    // Theme Colors from Assets
    let darkBackground = Color(hex: "09090B") // zinc-950
    let primaryColor = Color("Primary")
    let secondaryColor = Color("Secondary")
    let zinc400 = Color("Zinc400")
    let zinc500 = Color("Zinc500")
    let appicon = Image("Logo")
    
    var body: some View {
        ZStack {
            if viewModel.isActive {
            
            } else {
                // Premium Modern Dark Background
                Color.black.ignoresSafeArea()
                
                darkBackground
                    .ignoresSafeArea()
                
                // Subtle Radial Glow from Top using Primary and Secondary
                RadialGradient(
                    gradient: Gradient(colors: [primaryColor.opacity(0.15), .clear]),
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
                                    .stroke(zinc500.opacity(0.3), lineWidth: 1)
                            )
                        
                        // Custom App Logo
                        appicon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 190, height: 190)
                            // If you want the image to be styled by primaryColor, uncomment the line below (requires a transparent PNG):
                            // .renderingMode(.template) 
                            // .foregroundColor(primaryColor)
                            .shadow(color: primaryColor.opacity(0.5), radius: 10, x: 0, y: 0)
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
                            .foregroundColor(zinc400)
                    }
                    .scaleEffect(viewModel.scale)
                    .opacity(viewModel.opacity)
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
static var previews: some View {
SplashView()
.environmentObject(ThemeManager())
}
}

