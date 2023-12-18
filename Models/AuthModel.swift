
import Foundation
struct AuthModel: Identifiable, Codable{
    var id = UUID()
    var email: String
    var password: String
}
