//
//  MainViewController.swift
//  PomodoraUIKit
//
//  Created by Али  on 06.05.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UITabBar.appearance().barTintColor = .lightGray
        UITabBar.appearance().isTranslucent = false
        tabBar.tintColor = .white
        let vc1 = UINavigationController(rootViewController: ViewController())
        let vc2 = UINavigationController(rootViewController: SettingsViewController())
        let vc3 = UINavigationController(rootViewController: HistoryViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "gearshape")
        vc3.tabBarItem.image = UIImage(systemName: "doc")
        
        vc1.title = "Home"
        vc2.title = "Settings"
        vc3.title = "History"
        
        tabBar.tintColor = .white
        
        setViewControllers([vc1,vc2,vc3], animated: true)

        
        
//        setupViewControllers()
    }
    
//    func setupViewControllers() {
//        viewControllers = [
//            wrapInNavigationController(with: ViewController(), tabTitle: "Home", tabImage: UIImage(systemName: "house")!),
//            wrapInNavigationController(with: ViewController(), tabTitle: "Search", tabImage: UIImage(systemName: "magnifyingglass")!),
//            wrapInNavigationController(with: ViewController(), tabTitle: "Profile", tabImage: UIImage(systemName: "person")!),
//        ]
//    }
//
//    func wrapInNavigationController(with rootViewController: UIViewController,
//                                    tabTitle: String,
//                                    tabImage: UIImage) -> UINavigationController
//    {
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        navigationController.tabBarItem.title = tabTitle
//        navigationController.tabBarItem.image = tabImage
//        navigationController.navigationBar.prefersLargeTitles = true
//        rootViewController.navigationController?.title = tabTitle
//        return navigationController
//    }

}
