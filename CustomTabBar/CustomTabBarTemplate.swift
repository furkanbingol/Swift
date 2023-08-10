import UIKit

final class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        selectedIndex = 0
        adjustableTabBarItemTitle()
    }
    
    private func adjustableTabBarItemTitle() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    // Add Background to Active Item
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let removeSelectedBackground = {
            tabBar.subviews.filter({ $0.layer.name == "TabBackgroundView" }).first?.removeFromSuperview()
        }

        let addSelectedBackground = { (bgColour: UIColor) in
            let tabIndex = CGFloat(tabBar.items!.firstIndex(of: item)!)
            print(tabIndex)
            let tabWidth = tabBar.bounds.width / CGFloat(tabBar.items!.count)
            print(tabWidth)
            let bgView = UIView(frame: CGRect(x: tabWidth * tabIndex, y: 0, width: tabWidth, height: tabBar.bounds.height - 30))
            bgView.layer.cornerRadius = 15
            bgView.backgroundColor = bgColour
            bgView.layer.name = "TabBackgroundView"
            tabBar.insertSubview(bgView, at: 0)
        }

        removeSelectedBackground()
        addSelectedBackground(.appColorLightest)
    }
    
}

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController),
            let tabItems = tabBarController.tabBar.items {

            let currentTabItem = tabItems[index]
            
            switch index {
            case 0:
                currentTabItem.selectedImage = UIImage(systemName: "book.fill")
            case 1:
                currentTabItem.selectedImage = UIImage(systemName: "newspaper.fill")
            case 2:
                currentTabItem.selectedImage = UIImage(systemName: "character.book.closed.fill")
            case 3:
                currentTabItem.selectedImage = UIImage(systemName: "bookmark.fill")
            case 4:
                currentTabItem.selectedImage = UIImage(systemName: "person.text.rectangle.fill")
            default:
                break
            }


            // # Bounce Animation #
            /*
            let tabItemView = currentTabItem.value(forKey: "view") as? UIView
            if let selectedView = tabItemView {
                UIView.animate(withDuration: 0.2, animations: {
                    selectedView.transform = CGAffineTransform(scaleX: 1.11, y: 1.11)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2) {
                        selectedView.transform = .identity
                    }
                })
            }
            */

        }
        return true
    }

}
