//
//  BaseTabBarController.swift
//  WinkPay
//
//  Created by Sathish on 02/10/19.
//

import UIKit

// MARK: Base Navigation Controller
class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        self.moveToDashboard()
    }
    
    fileprivate func moveToDashboard() {
        
        let baseTabBar: BaseTabBarController = BaseTabBarController.instantiate(fromStoryboard: .winkPay)
        self.setViewControllers([baseTabBar], animated: true)
    }
}

// MARK: TabBar Controller
class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Dashboard ViewController
class DashboardViewController: UIViewController {
    
    fileprivate let logTag = "[DashboardViewController]➤"
    
    override func viewDidLoad() {
        logMessage("\(logTag) \(#function)")
    }
}
