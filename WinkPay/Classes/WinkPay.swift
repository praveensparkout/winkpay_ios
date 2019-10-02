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
    
    var appWindow: UIWindow
    var clientId: String
    var userId: String
    
    var podType: PodType = .withUI
            
    private init(with appWindow: UIWindow, userId: String, clientId: String) {
        self.appWindow = appWindow
        self.userId = userId
        self.clientId = clientId
    }
    
    public class func initialize(with appWindow: UIWindow, userId: String, clientId: String) {
        if shared != nil { /* Do Cleanup's before initializing */ }
        shared = WinkPay(with: appWindow, userId: userId, clientId: clientId)
    }
    
    deinit {}
}
