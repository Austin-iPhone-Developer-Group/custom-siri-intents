import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        refreshColor()
    }
    
    func refreshColor() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let viewController = self.window!.rootViewController!
            if let
            = UserDefaults(suiteName: "group.com.intenting")?.string(forKey: "color") {
                viewController.view.backgroundColor = ViewController.Color(string: colorString).uiColor
            }
            self.refreshColor()
        }
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == "com.intending.view-viewcontroller" {
            let viewController = window!.rootViewController!
            if let colorString = userActivity.userInfo?["color"] as? String {
                viewController.view.backgroundColor = ViewController.Color(string: colorString).uiColor
            }
            restorationHandler([viewController])
            return true
        }
        return false
    }

}

