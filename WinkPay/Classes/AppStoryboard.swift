//
//  AppStoryboard.swift
//  WinkPay
//
//  Created by Sathish on 30/09/19.
//

import Foundation
import UIKit


// MARK: Storyboard
protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension UIViewController: StoryboardIdentifiable {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func instantiate(fromStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

// MARK: Storyboards
enum AppStoryboard: String {
    
    //Tabs
    case winkPay = "winkPay"
    case dashboard = "winkPayDashboard"
    
    var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Helper.getBundle())
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardIdentifier
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T else {
            fatalError("ViewController with identifier \(storyboardId), not found")
        }
        return vc
    }
    
    func viewController<T: UIViewController>(withIdentifier identifier: SBIdentifier) -> T {
        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier.id) as? T else {
            fatalError("ViewController with identifier \(identifier.id), not found")
        }
        return vc
    }
}

// MARK: UIStoryboard
extension UIStoryboard {
    
    convenience init(storyboard: AppStoryboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    //instatiate for particulate id
    func instantiateViewController<T: UIViewController>(withidentifier Identifier: SBIdentifier) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: Identifier.rawValue) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(Identifier) ")
        }
        return viewController
    }
    
    //instantiate with ViewController name
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        return viewController
    }
}

// MARK: Storyboard Identifiers
enum SBIdentifier: String {
    
    case newChatVc = ""
    
    var id: String {
        return self.rawValue
    }
    
    var viewController: UIViewController {
        let storyboard = UIStoryboard(name: AppStoryboard.winkPay.rawValue, bundle:nil)
        return storyboard.instantiateViewController(withIdentifier: self.rawValue)
    }
}
