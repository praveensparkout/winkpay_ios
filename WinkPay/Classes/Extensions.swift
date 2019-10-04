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
}

struct WinkImage {
    static func getImage(named: String) -> UIImage? {
        let bundle: Bundle? = Helper.getBundle()
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
