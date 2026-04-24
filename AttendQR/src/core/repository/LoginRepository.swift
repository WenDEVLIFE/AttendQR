import Foundation
import Combine
import Supabase

/// Model representing a user from the database
struct UserSession: Codable {
    let email: String
    let username: String?
    let full_name: String?
    let role: String
    let image_url: String?
}

/// Repository handling authentication requests via database tables
class LoginRepository {
    private let client = SupabaseManager.shared.client
    
    /// Login request using direct database query (Table-Based Auth)
    func login(email: String, password: String) -> AnyPublisher<UserSession?, Error> {
        Future { promise in
            Task {
                do {
                    // Query the users table for matching credentials
                    let results: [UserSession] = try await self.client.database
                        .from("users")
                        .select()
                        .eq("email", value: email)
                        .eq("password", value: password)
                        .execute()
                        .value
                    
                    if let user = results.first {
                        promise(.success(user))
                    } else {
                        let error = NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid email or password."])
                        promise(.failure(error))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
