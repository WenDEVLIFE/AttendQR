import Foundation
import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    @Published var isActive = false
    @Published var scale: CGFloat = 0.8
    @Published var opacity: Double = 0.0
    
    func onAppear() {
        // Animate elements in using a smooth spring
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0)) {
            self.scale = 1.0
            self.opacity = 1.0
        }
        
        // Wait and then transition to next screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                self.isActive = true
            }
        }
    }
}
