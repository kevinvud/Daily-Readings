//
//  MainTabBarController.swift
//  Daily Readings
//
//  Created by PoGo on 10/26/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        
        tabBar.tintColor = UIColor.rgb(red: 59, green: 104, blue: 198)
        
        let firstController = templateNavController(tabTitle: "Bài Đọc", image: #imageLiteral(resourceName: "read"), rootViewController: DailyReadingsController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let secondController = templateNavController(tabTitle: "Tin Tức", image: #imageLiteral(resourceName: "news"), rootViewController: RssCategoriesController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let thirdController = templateNavController(tabTitle: "Thông Tin", image: #imageLiteral(resourceName: "menu"), rootViewController: MoreMenuController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        viewControllers = [firstController, secondController, thirdController]
        
//        guard let items = tabBar.items else { return }
        
//        for item in items {
//            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
//        }
        
        
    }
    
    fileprivate func templateNavController(tabTitle: String, image: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = image
        navController.tabBarItem.title = tabTitle
        if screenSize.width < 768 && !UIDeviceOrientationIsLandscape(UIDeviceOrientation.landscapeLeft) || !UIDeviceOrientationIsLandscape(UIDeviceOrientation.landscapeRight) {
              navController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        }
        return navController
    }


}
