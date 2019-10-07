//
//  WinkFont.swift
//  WinkPay
//
//  Created by Sathish on 07/10/19.
//

import Foundation
import UIKit

extension UIFont {
    
    func registerFonts() {
        
        guard let bundle = Helper.getBundle() else { return }
        
        let fonts = [bundle.url(forResource: "SourceSansPro-ExtraLight", withExtension: "otf"),
                     bundle.url(forResource: "SourceSansPro-Regular", withExtension: "otf"),
                     bundle.url(forResource: "SourceSansPro-Bold", withExtension: "otf"),
                     bundle.url(forResource: "SourceSansPro-Semibold", withExtension: "otf"),
                     bundle.url(forResource: "SourceSansPro-Light", withExtension: "otf")]
        
        for url in fonts.compactMap({ $0 }) {
            
            // Create a CGDataPRovider and a CGFont from the URL.
            guard let fontDataProvider = CGDataProvider(url: url as CFURL) else { return }
            
            guard let font = CGFont(fontDataProvider) else { return }
            
            // Register the font with the system.
            var error: Unmanaged<CFError>?
            _ = CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}


struct AppFont {
    
    static func regular(size: CGFloat) -> UIFont {
        return FontManager(.installed(.regular), size: .custom(size)).instance
    }
    
    static func dynamicRegular(size: CGFloat, maxSize: CGFloat) -> UIFont {
        let customFont = FontManager(.installed(.regular), size: .custom(size)).instance
         return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
    
    /// Medium
    static func medium(size: CGFloat) -> UIFont {
        return FontManager(.installed(.medium), size: .custom(size)).instance
    }
    
    static func dynamicMedium(size: CGFloat, maxSize: CGFloat = 30) -> UIFont {
        let customFont = FontManager(.installed(.medium), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
    
    /// Bold
    static func bold(size: CGFloat) -> UIFont {
        return FontManager(.installed(.bold), size: .custom(size)).instance
    }
    
    static func dynamicBold(size: CGFloat, maxSize: CGFloat = 20) -> UIFont {
        let customFont = FontManager(.installed(.bold), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
    
    static func boldItalic(size: CGFloat) -> UIFont {
        return FontManager(.installed(.boldItalic), size: .custom(size)).instance
    }
    
    /// SemiBold
    static func semiBold(size: CGFloat) -> UIFont {
        return FontManager(.installed(.semiBold), size: .custom(size)).instance
    }
    
    static func dynamicSemiBold(size: CGFloat, maxSize: CGFloat) -> UIFont {
        let custom = FontManager(.installed(.semiBold), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: custom, maximumPointSize: maxSize)
    }
    
    static func lightFont(size: CGFloat) -> UIFont {
        return FontManager(.installed(.light), size: .custom(size)).instance
    }
        
    static func font(forType type: FontManager.FontStyle, size: CGFloat) -> UIFont {
        return FontManager(.installed(type), size: .custom(size)).instance
    }
    
    static func dynamicFont(forType type: FontManager.FontStyle, size: CGFloat) -> UIFont {
        let customFont = FontManager(.installed(type), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont)
    }
    
    /// Dynamic Font Size with Max font size
    static func dynamicFont(forType type: FontManager.FontStyle, size: CGFloat, maxSize: CGFloat = 34) -> UIFont {
        let customFont = FontManager(.installed(type), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
}



/// A `UIFontMetrics` wrapper, allowing iOS 11 devices to take advantage of `UIFontMetrics` scaling,
/// while earlier iOS versions fall back on a scale calculation.
///
struct FontMetrics {
    
    /// A scale value based on the current device text size setting. With the device using the
    /// default Large setting, `scaler` will be `1.0`. Only used when `UIFontMetrics` is not
    /// available.
    ///
    static var scaler: CGFloat {
        return UIFont.preferredFont(forTextStyle: .body).pointSize / 17.0
    }
    
    /// Returns a version of the specified font that adopts the current font metrics.
    ///
    /// - Parameter font: A font at its default point size.
    /// - Returns: The font at its scaled point size.
    ///
    static func scaledFont(for font: UIFont) -> UIFont {
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledFont(for: font)
        } else {
            return font.withSize(scaler * font.pointSize)
        }
    }
    
    /// Returns a version of the specified font that adopts the current font metrics and is
    /// constrained to the specified maximum size.
    ///
    /// - Parameters:
    ///   - font: A font at its default point size.
    ///   - maximumPointSize: The maximum point size to scale up to.
    /// - Returns: The font at its constrained scaled point size.
    ///
    static func scaledFont(for font: UIFont, maximumPointSize: CGFloat) -> UIFont {
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledFont(for: font,
                                                    maximumPointSize: maximumPointSize,
                                                    compatibleWith: nil)
        } else {
            return font.withSize(min(scaler * font.pointSize, maximumPointSize))
        }
    }
    
    /// Scales an arbitrary layout value based on the current Dynamic Type settings.
    ///
    /// - Parameter value: A default size value.
    /// - Returns: The value scaled based on current Dynamic Type settings.
    ///
    static func scaledValue(for value: CGFloat) -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledValue(for: value)
        } else {
            return scaler * value
        }
    }
}



enum FontFamily: String {

    case sourcesanspro = "sourcesanspro"
    
    var name: String {
        return self.rawValue
    }
}

struct FontManager {
    
    enum FontType {
        case installed(FontStyle)
        case custom(String)
        case system
        case systemBold
        case systemItatic
    }
    //semibold, medium, regular, bold, right, sembold italic
    enum FontStyle: String {
        
        case regular = "Regular"
        
        case light = "Light"
        case lightItalic = "LightItalic"
        
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        
        case semiBold = "Semibold"
        case semiboldItalic = "SemiboldItalic"
        
        case thin = "Thin"
        case thinItalic = "ThinItalic"
        
        case black = "Black"
        case blackItalic = "BlackItalic"
        
        case hairline = "Hairline"
        case hairlineItalic = "HairlineItalic"
        
        case heavy = "Heavy"
        case heavyItalic = "HeavyItalic"
    }
    
    enum FontSize {
        case standard(StandardSize)
        case custom(CGFloat)
        var value: CGFloat {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    
    enum StandardSize: CGFloat {
        case h1 = 20.0
        case h2 = 18.0
        case h3 = 16.0
        case h4 = 14.0
        case h5 = 12.0
        case h6 = 10.0
    }
    
    var type: FontType
    var size: FontSize
    
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension FontManager {
    
    var instance: UIFont {
        
        var instanceFont: UIFont!
        
        switch type {
            
        case .custom(let fontName):
            guard let font =  UIFont(name: fontName, size: size.value) else {
                fatalError("\(fontName) font is not installed.")
            }
            instanceFont = font
            
        case .installed(let fontStyle):
            guard let font =  UIFont(name: "\(AppFontFamily.rawValue)-\(fontStyle.rawValue)", size: size.value) else {
                fatalError("\(AppFontFamily.rawValue)-\(fontStyle.rawValue) font is not installed.")
            }
            instanceFont = font
            
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        }
        
        return instanceFont
    }
    
    /* Usage Examples
     
     let system12            = Font(.system, size: .standard(.h5)).instance
     let robotoThin20        = Font(.installed(.RobotoThin), size: .standard(.h1)).instance
     let robotoBlack14       = Font(.installed(.RobotoBlack), size: .standard(.h4)).instance
     let helveticaLight13    = Font(.custom("Helvetica-Light"), size: .custom(13.0)).instance
     
     */
}
