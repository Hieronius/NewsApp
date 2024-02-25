import UIKit

extension UINavigationController {
    
    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return viewControllers.first(where: { $0 is T })
    }
}
