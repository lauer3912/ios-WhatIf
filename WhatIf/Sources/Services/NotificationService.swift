import Foundation
import UserNotifications

class NotificationService {

    static let shared = NotificationService()

    private let center = UNUserNotificationCenter.current()
    private let dailyReminderIdentifier = "com.ggsheng.WhatIf.dailyReminder"

    private init() {}

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            DispatchQueue.main.async { completion(granted) }
        }
    }

    func scheduleRandomWhatIfReminder() {
        center.removePendingNotificationRequests(withIdentifiers: [dailyReminderIdentifier])

        let content = UNMutableNotificationContent()
        content.title = "🌀 What If Machine"
        content.body = "What if gravity was just a suggestion? Tap to generate your next absurd answer!"
        content.sound = .default

        // Random time between 10am-8pm
        let hour = Int.random(in: 10...20)
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: DateComponents(hour: hour, minute: 0),
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: dailyReminderIdentifier,
            content: content,
            trigger: trigger
        )

        center.add(request) { error in
            if let e = error { print("Notification error: \(e)") }
        }
    }

    func cancelAll() {
        center.removePendingNotificationRequests(withIdentifiers: [dailyReminderIdentifier])
    }

    var isEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "WhatIf.notificationsEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "WhatIf.notificationsEnabled") }
    }

    func toggle(enabled: Bool, completion: @escaping (Bool) -> Void) {
        if enabled {
            requestAuthorization { [weak self] granted in
                if granted {
                    self?.isEnabled = true
                    self?.scheduleRandomWhatIfReminder()
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } else {
            isEnabled = false
            cancelAll()
            completion(true)
        }
    }

    func restoreScheduledNotifications() {
        if isEnabled { scheduleRandomWhatIfReminder() }
    }
}
