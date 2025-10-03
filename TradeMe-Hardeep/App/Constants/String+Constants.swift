//
//  String+Constants.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

struct Constants {
    
    // MARK: - TabBar View
    struct Tabbar {
        
        struct Discovery {
            static let title = "Discover"
            static let icon = ImageName.search
            static let accessibility = AccessibilityModel(id: "tabbar.discover", label: "Discover")
        }

        struct Watchlist {
            static let title = "Watchlist"
            static let icon = ImageName.watchlist
            static let accessibility = AccessibilityModel(id: "tabbar.watchlist", label: "Watchlist")
        }
        
        struct MyTradeMe {
            static let title = "My Trade Me"
            static let icon = ImageName.profile
            static let accessibility = AccessibilityModel(id: "tabbar.myTradeMeTab", label: "My Trade Me")
        }
        
    }
    
    struct DiscoverScreen {
        static let navTitle = "Browse"
        static let searchButton = AccessibilityModel(id: "browseScreen.button.search", label: "Search")
        static let cartButton = AccessibilityModel(id: "discoverScreen.button.cart", label: "Cart")
    }
    
    struct WatchlistScreen {
        static let navTitle = "Watchlist"
    }
   
    struct MyTradeMe {
        static let navTitle = "My Trade Me"
    }
    
    struct DiscoverScreenRow {
        static let buyNow = "Buy Now"
        static let buyNowAccessibility = AccessibilityModel(id: "discoverScreen.row.buyNow", label: "Buy Now")
        
        static let location = "Location"
        static let locationAccessibility = AccessibilityModel(id: "discoverScreen.row.location", label: "Location")
        
        static let title = "Title"
        static let titleAccessibility = AccessibilityModel(id: "discoverScreen.row.title", label: "Title")
    }
    
    static let ok = "Ok"
    static let buyNow = "Buy Now"
}


// MARK: - Accessibility Helper

struct AccessibilityModel {
    
    let id: String
    let label: String
    let hint: String?
    let value: String?
    let traits: AccessibilityTraits
    
    init(id: String, label: String, hint: String? = nil, value: String? = nil, traits: AccessibilityTraits = []) {
        self.id = id
        self.label = label
        self.hint = hint
        self.value = value
        self.traits = traits
    }
    
}

extension View {
    
    func addAccessibility(model: AccessibilityModel, value: String = "") -> some View {
        self
            .accessibilityIdentifier(model.id)
            .accessibilityLabel(model.label)
            .accessibilityHint(model.hint ?? "")
            .accessibilityValue(model.value ?? value)
            .accessibilityAddTraits(model.traits)
    }
    
}



