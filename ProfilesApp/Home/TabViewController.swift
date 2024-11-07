//
//  TabViewController.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 08/11/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    private var token: String
    
    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createViewController(viewController: createEmptyViewController(),
                                 title: "Discover",
                                 imageName: "square.grid.2x2"),
            createViewController(viewController: HomeViewController(token: token), title: "Notes", imageName: "envelope"),
            createViewController(viewController: createEmptyViewController(),
                                 title: "Matches",
                                 imageName: "message"),
            createViewController(viewController: createEmptyViewController(),
                                 title: "Profile",
                                 imageName: "person.fill")
        ]
        
        selectedIndex = 1 
    }
    
    private func createViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        viewController.title = title
        viewController.tabBarItem.image = UIImage(systemName: imageName)
        viewController.tabBarItem.title = title
        return viewController
    }
    
    private func createEmptyViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        return viewController
    }

}
