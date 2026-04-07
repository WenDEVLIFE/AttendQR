import SwiftUI
import Combine

/// ViewModel for the Login View handling authentication state and validation
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var loginSuccess = false
    
    private let repository: LoginRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: LoginRepository = LoginRepository()) {
        self.repository = repository
    }
    
    /// Handles the login process
    func login() {
        // Simple validation
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address."
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        repository.login(email: email, password: password)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] success in
                self?.loginSuccess = success
            })
            .store(in: &cancellables)
    }
    
    /// Clear error messages
    func clearError() {
        errorMessage = nil
    }
    
    // MARK: - Validation Helpers
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
