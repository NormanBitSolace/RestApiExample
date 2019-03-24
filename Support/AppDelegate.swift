import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataService: PetService = PetServiceImpl()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "ViewController", bundle: nil)
        if let rootVC = storyboard.instantiateInitialViewController() as? ViewController {
            window?.rootViewController = UINavigationController(rootViewController: rootVC)
            ViewModelBuilder.petVetTableCellViewModels(petService: dataService) { viewModels in
                rootVC.data = viewModels
            }
        }
        window?.makeKeyAndVisible()
        return true
    }
}
