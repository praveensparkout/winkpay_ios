//
//  Constants.swift
//  WinkPay
//
//  Created by Sathish on 30/09/19.
//

import Foundation

struct Helper {
    
    static let sdkName: String = "WinkPay"
    
    static func getBundle() -> Bundle? {
        let podBundle = Bundle(for: WinkPay.self)
        guard let bundleUrl = podBundle.url(forResource: sdkName, withExtension: "bundle") else {
            return nil
        }
        guard let bundle = Bundle(url: bundleUrl) else { return nil }
        return bundle
    }
    
    static func getStoryboard() -> UIStoryboard {
        let storyBoard: UIStoryboard = UIStoryboard(name: "WinkPay", bundle: Helper.getBundle()!)
        return storyBoard
    }
}

/// ERROR Descriptions
enum WinkPayError: Error {
    case invaid
    
    var description: String {
        switch self {
        case .invaid: return "Invalid Data"
        }
    }
}


/// ERROR Log Messages
public func logMessage(_ string: String, canLog: Bool = true) {
    guard WinkPay.shared.enableLog, canLog else { return }
    print(string)
}

public func logWarning(_ string: String) {
    guard WinkPay.shared.enableLog else { return }
    print("\(string) ⚠️")
}

public func logError(_ error: Error) {
    guard WinkPay.shared.enableLog else { return }
    guard let err = error as? WinkPayError else {
        print("ERROR: \(error.localizedDescription)")
        return
    }
    print("❌ \(err.description)")
}

public func logError(_ string: String) {
    guard WinkPay.shared.enableLog else { return }
    print("❌ \(string)")
}

public func SwiftAssertIsOnMainThread(_ function: String) {
    assert(Thread.isMainThread, "\(function) not on main thread")
}
