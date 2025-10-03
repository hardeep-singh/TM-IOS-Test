//
//  Fonts+Typography.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

// MARK: - Typography
struct Typography {
    
    // MARK: - Font Names
    struct FontName {
        static let light = "HelveticaNeue-Light"
        static let regular = "HelveticaNeue"
        static let medium = "HelveticaNeue-Medium"
        static let bold = "HelveticaNeue-Bold"
    }
    
    // MARK: - Font Sizes
    struct Size {
        static let title1: CGFloat = 16
        static let title2: CGFloat = 14

        static let subtitle1: CGFloat = 12
    }
    
}

// MARK: - Font Extension (TradeMe Typography)
extension Font {
    
    // MARK: - Title Fonts (Medium, Medium Size)
    static let tmTitle1 = Font.custom(Typography.FontName.medium, size: Typography.Size.title1)
    static let tmTitle2 = Font.custom(Typography.FontName.medium, size: Typography.Size.title2)

    static let tmSubtitle1 = Font.custom(Typography.FontName.regular, size: Typography.Size.subtitle1)
        
}
