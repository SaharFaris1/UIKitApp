
import Foundation
final class AuthService: ObservableObject {
    
    static let shared = AuthService()
    
   // @Published var user: User? = nil
    var token: String = ""
    
    @Published var loggedIn: Bool = false
    @Published var isDarkMode: Bool = false
   
}
