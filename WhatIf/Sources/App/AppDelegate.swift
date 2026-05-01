import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureAppearance()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    private func configureAppearance() {
        let navBar = UINavigationBarAppearance()
        navBar.configureWithOpaqueBackground()
        navBar.backgroundColor = UIColor(hex: "#1A0A2E") ?? .black
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navBar
        UINavigationBar.appearance().scrollEdgeAppearance = navBar
        UINavigationBar.appearance().tintColor = UIColor(hex: "#FFB347") ?? .orange

        let tabBar = UITabBarAppearance()
        tabBar.configureWithOpaqueBackground()
        tabBar.backgroundColor = UIColor(hex: "#1A0A2E") ?? .black
        UITabBar.appearance().standardAppearance = tabBar
        UITabBar.appearance().scrollEdgeAppearance = tabBar
        UITabBar.appearance().tintColor = UIColor(hex: "#FFB347") ?? .orange
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var h = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        h = h.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        guard Scanner(string: h).scanHexInt64(&rgb) else { return nil }
        self.init(red: CGFloat((rgb >> 16) & 0xFF)/255,
                   green: CGFloat((rgb >> 8) & 0xFF)/255,
                   blue: CGFloat(rgb & 0xFF)/255, alpha: 1)
    }
}