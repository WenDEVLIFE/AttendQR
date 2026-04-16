import SwiftUI

struct UserScanView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
            AppColors.adaptiveBackground()
            
            VStack(spacing: 32) {
                // Header
                HStack {
                    CustomText(
                        title: "Scan QR Code",
                        fontSize: 24,
                        fontColor: .white,
                        weight: .bold
                    )
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                Spacer()
                
                // Scan Area Mockup
                ZStack {
                    // Camera Placeholder (Dark Gray)
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color.white.opacity(0.05))
                        .frame(width: 280, height: 280)
                    
                    // Scanning Corners
                    VStack {
                        HStack {
                            cornerShape(rotation: 0)
                            Spacer()
                            cornerShape(rotation: 90)
                        }
                        Spacer()
                        HStack {
                            cornerShape(rotation: 270)
                            Spacer()
                            cornerShape(rotation: 180)
                        }
                    }
                    .frame(width: 300, height: 300)
                    
                    // Horizontal Scanning Line (Animated placeholder)
                    Rectangle()
                        .fill(AppColors.accent)
                        .frame(width: 260, height: 2)
                        .shadow(color: AppColors.accent, radius: 10)
                }
                
                VStack(spacing: 12) {
                    CustomText(
                        title: "Position the QR code within the frame",
                        fontSize: 16,
                        fontColor: .white,
                        weight: .medium
                    )
                    
                    CustomText(
                        title: "Checking-in will be automatic once detected",
                        fontSize: 14,
                        fontColor: AppColors.textTertiary,
                        weight: .regular
                    )
                }
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                // Flash/Actions
                HStack(spacing: 40) {
                    actionCircle(icon: "bolt.fill")
                    actionCircle(icon: "photo.on.rectangle.angled")
                }
                .padding(.bottom, 120)
            }
        }
    }
    
    private func cornerShape(rotation: Double) -> some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 30))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 30, y: 0))
        }
        .stroke(AppColors.accent, lineWidth: 4)
        .frame(width: 30, height: 30)
        .rotationEffect(.degrees(rotation))
    }
    
    private func actionCircle(icon: String) -> some View {
        Button(action: {}) {
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 56, height: 56)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                )
        }
    }
}

#Preview {
    UserScanView()
        .environmentObject(ThemeManager())
}
