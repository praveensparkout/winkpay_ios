//
//  Constants.swift
//  WinkPay
//
//  Created by Sathish on 30/09/19.
//

import Foundation

let AppFontFamily: FontFamily = .sourcesanspro
let winkApiManager: WinkApiManager = WinkApiManager()

// MARK: Helper
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
    
    static func registerFonts() {
        UIFont().registerFonts()
    }

}

/// ERROR Descriptions
enum WinkPayError: Error {
    case invaid
    case emptyJSON
    case winkPayWindowNotFound
    
    var description: String {
        switch self {
        case .invaid: return "Invalid Data"
        case .emptyJSON: return "Empty Response"
        case .winkPayWindowNotFound: return "WinkPay Window Not Found"
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

/// App Color

struct AppColor {
    
    static let tintColor = UIColor(rawRGBValue: 116, green: 41, blue: 214, alpha: 1)
}
