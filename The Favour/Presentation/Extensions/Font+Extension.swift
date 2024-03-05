//
//  Font+Extension.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI


enum DefaultFontFamily {
    case bold
    case black
    case medium
    case regular
    case extraLight
    case extraBold
    case semiBold
    case light
    case thin
    
    
    func englishFontFamily(fontSize: CGFloat) -> Font {
        switch self {
        case .bold:
            return Font.custom("UrbanistRoman-Bold", size: fontSize)
        case .black:
            return Font.custom("UrbanistRoman-Black", size: fontSize)
        case .medium:
            return Font.custom("UrbanistRoman-Medium", size: fontSize)
        case .regular:
            return Font.custom("Urbanist-Regular", size: fontSize)
        case .extraLight:
            return Font.custom("UrbanistRoman-ExtraLight", size: fontSize)
        case .extraBold:
            return Font.custom("UrbanistRoman-ExtraBold", size: fontSize)
        case .semiBold:
            return Font.custom("UrbanistRoman-SemiBold", size: fontSize)
        case .light:
            return Font.custom("UrbanistRoman-Light", size: fontSize)
        case .thin:
            return Font.custom("UrbanistRoman-Thin", size: fontSize)

        }
    }
    
}


enum UrbanistFonts: String {
    case bold = "UrbanistRoman-Bold"
    case black = "UrbanistRoman-Black"
    case medium = "UrbanistRoman-Medium"
    case regular = "Urbanist-Regular"
    case extraLight = "UrbanistRoman-ExtraLight"
    case extraBold = "UrbanistRoman-ExtraBold"
    case semiBold = "UrbanistRoman-SemiBold"
    case light = "UrbanistRoman-Light"
    case thin = "UrbanistRoman-Thin"
}


extension Font {
    static func localizedFont(fontType: DefaultFontFamily, fontSize: CGFloat) -> Font {
        return urbanist(fontType: fontType, fontSize: fontSize)
    }
    

    static func urbanist(fontType: DefaultFontFamily, fontSize: CGFloat) -> Font {
        return fontType.englishFontFamily(fontSize: fontSize)
    }
    
    
}
