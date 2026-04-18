import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .systemGroupedBackground
        let nav = UINavigationController(rootViewController: AthleteTableViewController(style: .plain))
        nav.view.backgroundColor = .systemGroupedBackground
        window.rootViewController = nav
        self.window = window
        window.makeKeyAndVisible()
    }
}
