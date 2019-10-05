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

enum TabType: Int {
    
    case send = 0
    case receive
    case dashboard
    case add
    case withdraw
    
    var tabIcon: UIImage? {
                
        switch self {
        case .send:
            return WinkImage.getImage(named: "send_tab_icon")
        case .receive:
            return WinkImage.getImage(named: "receive_tab_icon")
        case .dashboard:
            return WinkImage.getImage(named: "dashboard_tab_icon")
        case .add:
            return WinkImage.getImage(named: "add_tab_icon")
        case .withdraw:
            return WinkImage.getImage(named: "withdraw_tab_icon")
        }
    }
    
    var selectedTabIcon: UIImage? {
        
        switch self {
        case .send:
            return WinkImage.getImage(named: "send_tab_icon_selected")
        case .receive:
            return WinkImage.getImage(named: "receive_tab_icon_selected")
        case .dashboard:
            return WinkImage.getImage(named: "dashboard_tab_icon_selected")
        case .add:
            return WinkImage.getImage(named: "add_tab_icon_selected")
        case .withdraw:
            return WinkImage.getImage(named: "withdraw_tab_icon")
        }
    }
    
    var title: String {
        
        switch self {
        case .send:
            return "Send"
        case .receive:
            return "Receive"
        case .dashboard:
            return "Dashboard"
        case .add:
            return "Add"
        case .withdraw:
            return "Withdraw"
        }
    }
}

// MARK: TabBar Controller
class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewControllers()
        setUpTabBar()
    }
    
    fileprivate func loadViewControllers() {
        
        let viewcontrollers: [UIViewController] =
            [SendViewController.instantiate(fromStoryboard: .send), ReceiveViewController.instantiate(fromStoryboard: .receive), DashboardViewController.instantiate(fromStoryboard: .dashboard), AddViewController.instantiate(fromStoryboard: .add), WithdrawViewController.instantiate(fromStoryboard: .withdraw)]
        
        self.viewControllers = viewcontrollers
    }
    
    fileprivate func setUpTabBar() {
        self.tabBar.tintColor = AppColor.tintColor
        guard let viewControllers = self.viewControllers else { return }
        
        for (index, vc) in viewControllers.enumerated() {
            guard let tabType = TabType(rawValue: index) else { return }
            let tabBarItem: UITabBarItem = UITabBarItem(title: tabType.title, image: tabType.tabIcon, selectedImage: tabType.selectedTabIcon)
            vc.tabBarItem = tabBarItem
            vc.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
        }
    }
}


class DashboardNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
    }
}

// MARK: Dashboard ViewController
class DashboardViewController: UIViewController {
    
    fileprivate let logTag = "[DashboardViewController]➤"
    
    fileprivate var configurator: DashboardConfigurator = DashboardConfiguratorImplementation()
    fileprivate var presenter: DashboardPresenter!
    
    override func viewDidLoad() {
        logMessage("\(logTag) \(#function)")
        configurator.configure(dashboardVC: self)
    }
}

extension DashboardViewController: DashboardView {
    
}

// MARK: Update View Related things from presenter
protocol DashboardView {
    
}

// MARK: Dashboard Configuration [Presenter & Router]
protocol DashboardConfigurator {
    func configure(dashboardVC: DashboardViewController)
}

class DashboardConfiguratorImplementation: DashboardConfigurator {
    
    func configure(dashboardVC: DashboardViewController) {
        let router = DashboardViewRouterImplementation(dashboardVC: dashboardVC)
        let presenter = DashboardPresenterImplementation(dashboardView: dashboardVC, router: router)
        dashboardVC.presenter = presenter
    }
}

// MARK: Business Logic
protocol DashboardPresenter {
    
}

class DashboardPresenterImplementation: DashboardPresenter {
    
    let dashboardView: DashboardView
    let router: DashboardViewRouter
    
    init(dashboardView: DashboardView, router: DashboardViewRouter) {
        self.dashboardView = dashboardView
        self.router = router
    }
}

// MARK: ViewController Routing
protocol DashboardViewRouter {
}

class DashboardViewRouterImplementation: DashboardViewRouter {
    
    var dashboardVC: DashboardViewController
    
    init(dashboardVC: DashboardViewController) {
        self.dashboardVC = dashboardVC
    }
}
