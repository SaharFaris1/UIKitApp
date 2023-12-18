
import SwiftUI
import Foundation
class NotificationViewModel: ObservableObject {
    @Published var toggleStates = [
        NotificationModel(title: "Email Notification", isOn: false),
        NotificationModel(title: "Screen Notification", isOn: false),
        NotificationModel(title: "Sound Notification", isOn: false),
        NotificationModel(title: "Vibration Notification", isOn: false),
    ]
    
}
