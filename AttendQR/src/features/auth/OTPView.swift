import SwiftUI

struct OTPView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var router: Router
    @State private var otpCode: [String] = Array(repeating: "", count: 4)
    @FocusState private var activeField: Int?
    
    var body: some View {
        ZStack {
            AppColors.adaptiveBackground(isDarkMode: themeManager.isDarkMode)
            
            VStack(spacing: 40) {
                // Header
                VStack(spacing: 16) {
                    HStack {
                        Button(action: { router.navigate(to: .register) }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    
                    CustomText(
                        title: "Verification",
                        fontSize: 32,
                        fontColor: .white,
                        weight: .bold
                    )
                    
                    CustomText(
                        title: "Enter the code sent to your email",
                        fontSize: 16,
                        fontColor: AppColors.textTertiary,
                        weight: .medium
                    )
                }
                .padding(.top, 40)
                
                // OTP Input Fields
                HStack(spacing: 16) {
                    ForEach(0..<4, id: \.self) { index in
                        OTPField(text: $otpCode[index], isFocused: activeField == index)
                            .focused($activeField, equals: index)
                            .keyboardType(.numberPad)
                            .onChange(of: otpCode[index]) { newValue in
                                otpCondition(value: newValue, index: index)
                            }
                    }
                }
                .padding(.horizontal, 40)
                
                VStack(spacing: 24) {
                    CustomButton(label: "Verify", onPressed: {
                        // Simulated verification
                        router.navigate(to: .main)
                    })
                    
                    Button(action: { /* Resend code */ }) {
                        HStack {
                            Text("Didn't receive a code?")
                                .foregroundColor(AppColors.textSecondary)
                            Text("Resend")
                                .foregroundColor(AppColors.accent)
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 14))
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
    }
    
    private func otpCondition(value: String, index: Int) {
        // Handle input change
        if value.count > 1 {
            otpCode[index] = String(value.suffix(1))
        }
        
        if !value.isEmpty {
            if index < 3 {
                activeField = index + 1
            } else {
                activeField = nil
            }
        } else {
            if index > 0 {
                activeField = index - 1
            }
        }
    }
}

struct OTPField: View {
    @Binding var text: String
    var isFocused: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.05))
                .frame(width: 60, height: 65)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isFocused ? AppColors.accent : Color.white.opacity(0.1), lineWidth: 2)
                )
            
            TextField("", text: $text)
                .multilineTextAlignment(.center)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    OTPView()
        .environmentObject(ThemeManager())
        .environmentObject(Router())
}
