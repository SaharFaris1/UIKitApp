
import Foundation
struct PreviousOrdersModel: Identifiable, Codable{
    var id = UUID()
    var restaurant: String
    var meal: String
    var userName: String
    var price: Int
    var date: String
    var deliverd: Bool
}
