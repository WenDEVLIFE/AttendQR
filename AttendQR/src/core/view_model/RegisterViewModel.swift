import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var registerSuccess = false
    
    func register() {
        // Basic validation
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All fields are required."
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Simulating a network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
            self.registerSuccess = true
        }
    }
}
