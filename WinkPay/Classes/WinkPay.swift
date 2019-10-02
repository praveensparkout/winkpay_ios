//
//  WinkPay.swift
//  WinkPay
//
//  Created by Sathish on 30/09/19.
//

import UIKit
import Foundation

public enum PodType {
    case withUI
    case withoutUI
}

open class WinkPay: NSObject {
    
    private let logTag = "[WinkPay]➤"
    open var enableLog: Bool = true
    
    /// Singleton
    public static var shared: WinkPay!
    
    var clientId: String
    var userId: String
    
    var podType: PodType = .withUI
            
    private init(userId: String, clientId: String) {
        self.userId = userId
        self.clientId = clientId
    }
    
    public class func initialize(with appWindow: UIWindow, userId: String, clientId: String) {
        if shared != nil { /* Do Cleanup's before initializing */ }
        shared = WinkPay(userId: userId, clientId: clientId)
        WinkPayViewRouter.shared.holdAppWindow(appWindow)
    }
    
    public func presentManager() {
        WinkPayViewRouter.shared.initializeWinkPayView()
    }
    
    deinit {
        logWarning("\(logTag) ♻️ De-Inited")
    }
}
