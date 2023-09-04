//
//  Font.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 04/09/2023.
//

import Foundation
import UIKit

enum FontFamily: String {
    case montserrat = "Montserrat"
}

enum FontWeight: String {
    case black = "Black"
    case blackitalic = "BlackItalic"
    case bold = "Bold"
    case bolditalic = "BoldItalic"
    case extralight = "ExtraLight"
    case extralightitalic = "ExtraLightItalic"
    case light = "Light"
    case lightitalic = "LightItalic"
    case medium = "Medium"
    case mediumitalic = "MediumItalic"
    case regular = "Regular"
    case semibold = "SemiBold"
    case semibolditalic = "SemiBoldItalic"
}

extension UIFont {
    static func appFont() -> UIFont {
        return UIFont(
            name: "Montserrat-Regular",
            size: 16
        ) ?? .systemFont(ofSize: 16)
    }

    static func appFont(ofSize: CGFloat) -> UIFont {
        return UIFont(
            name: "Montserrat-Regular",
            size: ofSize
        ) ?? .systemFont(ofSize: ofSize)
    }

    static func appFont(ofSize: CGFloat, weight: FontWeight) -> UIFont {
        return UIFont(
            name: "Montserrat-\(weight.rawValue)",
            size: ofSize
        ) ?? .systemFont(ofSize: ofSize, weight: .regular)
    }

    static func appFont(ofSize: CGFloat, weight: FontWeight, family: FontFamily) -> UIFont {
        return UIFont(
            name: "\(family.rawValue)-\(weight.rawValue)",
            size: ofSize
        ) ?? .systemFont(ofSize: ofSize, weight: .regular)
    }
}
