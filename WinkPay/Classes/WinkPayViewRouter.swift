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
        
        self.winkPayWindow?.rootViewController = baseNavController
        self.winkPayWindow?.makeKeyAndVisible()
        self.winkPayWindow?.fadeIn(duration: 0.1, delay: 1, completion: { _ in
            self.winkPayWindow?.makeKeyAndVisible()
        })

        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.winkPayWindow?.rootViewController = baseNavController
            self.winkPayWindow?.makeKeyAndVisible()
            self.winkPayWindow?.fadeIn(duration: 0.1, delay: 1, completion: { _ in
                self.winkPayWindow?.makeKeyAndVisible()
            })
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
}
