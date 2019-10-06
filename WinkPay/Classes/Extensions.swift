//
//  Extensions.swift
//  WinkPay
//
//  Created by Sathish on 02/10/19.
//

import Foundation
import UIKit

extension Optional {
    
    var isNill: Bool {
        return self == nil
    }
    
    var isNotNil: Bool {
        return self != nil
    }
    
    mutating func nillify() {
        self = nil
    }
}

extension Bool {
    
    var toggle: Bool {
        return !self
    }
    
    mutating func invert() {
        self = toggle
    }
    
    mutating func `true`() {
        self = true
    }
    mutating func `false`() {
        self = false
    }
    
    var isFalse: Bool {
        return self == false
    }
    
    var isTrue: Bool {
        return self == true
    }
}


extension UIColor {
    
    public convenience init(rawRGBValue red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.5,
                delay: TimeInterval = 0.0,
                completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5,
                 delay: TimeInterval = 0.0,
                 completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        self.alpha = 0.0
        }, completion: completion)
    }
    
    @discardableResult
    func setGradientBackground(colors: [UIColor], startPoint: GradientPoint, endPoint: GradientPoint) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    func addCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func addBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}

public enum GradientPoint {
    case topLeft
    case centerLeft
    case bottomLeft
    case topCenter
    case center
    case bottomCenter
    case topRight
    case centerRight
    case bottomRight
    var point: CGPoint {
        switch self {
        case .topLeft:
            return CGPoint(x: 0, y: 0)
        case .centerLeft:
            return CGPoint(x: 0, y: 0.5)
        case .bottomLeft:
            return CGPoint(x: 0, y: 1.0)
        case .topCenter:
            return CGPoint(x: 0.5, y: 0)
        case .center:
            return CGPoint(x: 0.5, y: 0.5)
        case .bottomCenter:
            return CGPoint(x: 0.5, y: 1.0)
        case .topRight:
            return CGPoint(x: 1.0, y: 0.0)
        case .centerRight:
            return CGPoint(x: 1.0, y: 0.5)
        case .bottomRight:
            return CGPoint(x: 1.0, y: 1.0)
        }
    }
}

/// Device Extension
public extension UIDevice {
    
    var isIphoneX: Bool {
        return UIDevice.current.modelName == "iPhone X"
    }
    
    var xDevices: [String] {
        return ["iPhone X", "iPhone XS", "iPhone XS Max", "iPhone XR"]
    }
    
    var isXDevice: Bool {
        return xDevices.contains(UIDevice.current.modelName)
    }
    
    var isIphoneMax: Bool {
        return UIDevice.current.modelName == "iPhone XS Max"
    }
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":
            return "iPod Touch 5"
        case "iPod7,1":
            return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return "iPhone 4"
        case "iPhone4,1":
            return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":
            return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":
            return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":
            return "iPhone 5s"
        case "iPhone7,2":
            return "iPhone 6"
        case "iPhone7,1":
            return "iPhone 6 Plus"
        case "iPhone8,1":
            return "iPhone 6s"
        case "iPhone8,2":
            return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":
            return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":
            return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":
            return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":
            return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":
            return "iPhone X"
        case "iPhone11,2":
            return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":
            return "iPhone XS Max"
        case "iPhone11,8":
            return "iPhone XR"
        case "i386", "x86_64":
            return "Simulator"
        case ".iPhoneX":
            return "iPhone X"
        case ".iPhoneXS":
            return "iPhone XS"
        case ".iPhoneXSMax":
            return "iPhone XS Max"
        case ".iPhoneXR":
                return "iPhone XR"
        case "iPad1,1" : return "iPad"
        case "iPad2,1" : return "iPad 2 (WiFi)"
        case "iPad2,2" : return "iPad 2 (GSM)"
        case "iPad2,3" : return "iPad 2 (CDMA)"
        case "iPad2,4" : return "iPad 2 (WiFi)"
        case "iPad2,5" : return "iPad Mini (WiFi)"
        case "iPad2,6" : return "iPad Mini (GSM)"
        case "iPad2,7" : return "iPad Mini (GSM+CDMA)"
        case "iPad3,1" : return "iPad 3 (WiFi)"
        case "iPad3,2" : return "iPad 3 (GSM+CDMA)"
        case "iPad3,3" : return "iPad 3 (GSM)"
        case "iPad3,4" : return "iPad 4 (WiFi)"
        case "iPad3,5" : return "iPad 4 (GSM)"
        case "iPad3,6" : return "iPad 4 (GSM+CDMA)"
        case "iPad4,1" : return "iPad Air (WiFi)"
        case "iPad4,2" : return "iPad Air (GSM)"
        case "iPad4,3" : return "iPad Air (LTE)"
        case "iPad4,4" : return "iPad Mini 2 (WiFi)"
        case "iPad4,5" : return "iPad Mini 2 (GSM)"
        case "iPad4,6" : return "iPad Mini 2 (LTE)"
        case "iPad4,7" : return "iPad Mini 3 (WiFi)"
        case "iPad4,8" : return "iPad Mini 3 (GSM)"
        case "iPad4,9" : return "iPad Mini 3 (LTE)"
        case "iPad5,1", "iPad5,2": return "iPad Mini 4"
        case "iPad5,3" : return "iPad Air 2 (WiFi)"
        case "iPad5,4" : return "iPad Air 2 (GSM)"
        case "iPad6,11", "iPad6,12" : return "iPad 5"
        case "iPad7,5", "iPad7,6" : return "iPad 6"
        case "iPad6,3", "iPad6,4": return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8": return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2": return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4": return "iPad Pro 10.5 Inch"
        default:
            return identifier
        }
    }
}

/// Get Image from AppBundle
struct WinkImage {
    static func getImage(named: String) -> UIImage? {
        let bundle: Bundle? = Helper.getBundle()
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}

/// WinkColors
struct WinkColors {
    
    struct Dashboard {
        static let balanceG1 = UIColor(rawRGBValue: 171, green: 116, blue: 242, alpha: 1)
        static let balanceG2 = UIColor(rawRGBValue: 137, green: 72, blue: 222, alpha: 0)
    }
    
}
