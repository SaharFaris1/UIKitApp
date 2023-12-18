
import Foundation
struct ProfileModel: Identifiable, Codable{
    var id: Int
    var uid = UUID()
    var name: String
    var email: String
    var photo: URL?
    var phoneNum: String
}
