import Foundation
import SwiftUI
import Combine

struct SettingsItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    var detail: String? = nil
}

class UserProfileViewModel: ObservableObject {
    @Published var userName: String = "Frouen Wenlake"
    @Published var email: String = "frouen.wen@example.com"
    @Published var attendeeId: String = "AQ-998234"
    @Published var attendanceRate: Double = 96.4
    @Published var points: Int = 4520
    @Published var status: String = "Active"
    
    let settingsGroups: [[SettingsItem]] = [
        [
            SettingsItem(title: "Account Details", icon: "person.fill", color: .blue),
            SettingsItem(title: "Event History", icon: "calendar", color: .green),
            SettingsItem(title: "Rewards & Points", icon: "star.fill", color: .yellow)
        ],
        [
            SettingsItem(title: "Notifications", icon: "bell.fill", color: .orange, detail: "On"),
            SettingsItem(title: "Security", icon: "lock.fill", color: .red),
            SettingsItem(title: "App Settings", icon: "gearshape.fill", color: .gray)
        ],
        [
            SettingsItem(title: "Help & Support", icon: "questionmark.circle.fill", color: .purple),
            SettingsItem(title: "About AttendQR", icon: "info.circle.fill", color: .blue)
        ]
    ]
}
