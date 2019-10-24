//
//  WinkPayViewRouter.swift
//  WinkPay
//
//  Created by Sathish on 02/10/19.
//

import Foundation
import UIKit

// MARK: Pod Window
class WinkPayWindow: UIWindow {
    deinit {
        logError("[WinkPayWindow]: ♻️ WinkPayWindow De-Inited")
    }
}

// MARK: Initialse View Router
class WinkPayViewRouter {
    
    private let logTag = "[WinkPayViewRouter]➤"
    static let shared = WinkPayViewRouter()
    
    var appWindow: UIWindow? = nil
    var winkPayWindow: UIWindow? = nil
    
    private init() {}
    
    func initializeWinkPayView() {
        constructWinkPayWindow()
        assert(winkPayWindow.isNotNil)
        
        let baseNavController: BaseNavigationController = BaseNavigationController.instantiate(fromStoryboard: .winkPay)
        
//        self.winkPayWindow?.rootViewController = baseNavController
//        self.winkPayWindow?.makeKeyAndVisible()
//        self.winkPayWindow?.fadeIn(duration: 0.1, delay: 1, completion: { _ in
//            self.winkPayWindow?.makeKeyAndVisible()
//        })

        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.winkPayWindow?.rootViewController = baseNavController
            self.winkPayWindow?.makeKeyAndVisible()
            self.winkPayWindow?.fadeIn(duration: 0.1, delay: 1, completion: { _ in
                self.winkPayWindow?.makeKeyAndVisible()
            })
            self.hideCallWindow()
        }
    }
    
    func holdAppWindow(_ window: UIWindow) {
        self.appWindow = window
    }
    
    private func constructWinkPayWindow() {
        /// Dismiss Keyboard
        UIApplication.shared.keyWindow?.endEditing(true)
        /// Construct WinkPayWindow
        self.winkPayWindow = WinkPayWindow(frame: UIScreen.main.bounds)
        self.winkPayWindow?.windowLevel = UIWindowLevelStatusBar - 1
        self.winkPayWindow?.makeKeyAndVisible()
        self.winkPayWindow?.alpha = 0
    }
    
    func showCallWindow() {
        
        guard let winkPayWindow = self.winkPayWindow else {
            logError(WinkPayError.winkPayWindowNotFound)
            return
        }
        
        guard winkPayWindow.isHidden else { return }
        winkPayWindow.makeKeyAndVisible()
        winkPayWindow.alpha = 0.0
        
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveLinear], animations: {
            winkPayWindow.alpha = 1.0
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                winkPayWindow.isHidden.false()
            })
        })
    }
    
    func hideCallWindow() {
        
        guard let winkPayWindow = self.winkPayWindow else {
            logError(WinkPayError.winkPayWindowNotFound)
            return
        }
        
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveLinear], animations: {
            winkPayWindow.alpha = 0.0
        }, completion: { _ in
            winkPayWindow.isHidden.true()
        })
    }
    
    func dismissView(withDelay delay: Double = 0.1) {
        
        guard let winkPayWindow = self.winkPayWindow else {
            logError(WinkPayError.winkPayWindowNotFound)
            return
        }
        
        guard let appWindow = self.appWindow else {
            logError(WinkPayError.winkPayWindowNotFound)
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            
            appWindow.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) // Scalling Normal Window to 0.8 (shrink)
            winkPayWindow.isUserInteractionEnabled = false
            
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
                
                appWindow.transform = CGAffineTransform.identity // Resetting back to the original place
                winkPayWindow.alpha = 0
                
            }, completion: { [weak self] (_) in
                
                winkPayWindow.isHidden = true
                winkPayWindow.rootViewController = nil
                winkPayWindow.removeFromSuperview()
                self?.winkPayWindow = nil
                
                appWindow.transform = CGAffineTransform.identity
                appWindow.makeKeyAndVisible()
            })
        }
    }
    
    deinit {
        winkPayWindow = nil
        logMessage("\(self.logTag) WinkPayView Router deinited")
    }
}

// MARK: Present without Window
extension WinkPayViewRouter {
    
    func presentWinkPay() {
        let baseNavController: BaseNavigationController = BaseNavigationController.instantiate(fromStoryboard: .winkPay)
        getTopViewController()?.present(baseNavController, animated: true, completion: nil)
    }
    
    func getTopViewController() -> UIViewController? {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController
        }
        return topVC
    }
}
