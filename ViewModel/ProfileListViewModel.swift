import SwiftUI
import Foundation
class ProfileDatabase: ObservableObject {
    @Published var profiledatabase: [ProfileData]
    
    init() {
        profiledatabase = [
           
            ProfileData(id: UUID(), proImage: "creditcard.circle.fill", proText: "Edit Profile", destination: EditProfileView()),
            ProfileData(id: UUID(), proImage: "bell", proText: "Notification Setting", destination: NotificationView()),
            ProfileData(id: UUID(), proImage: "questionmark.circle", proText: "Help Center", destination: HelpCenterView()),
            ProfileData(id: UUID(), proImage: "apple.terminal", proText: "Terms & Conditions", destination: TermsConditionView())
        ]
    }
}
