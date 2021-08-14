import UIKit

@main
final class AppDelegate: UIResponder {
    private let appDI = AppDI()
    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appDI.rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
