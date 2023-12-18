
import Foundation
struct LogInModel : Identifiable , Codable{
    
    let id: UUID?
    let email: String
    let password: String
    
}
