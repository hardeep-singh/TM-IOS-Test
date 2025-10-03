//
//  TabbarView.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            
            LatestListingsView(viewModel: LatestListingsViewModel())
                .tabItem { Label(Constants.Tabbar.Discovery.title, image: Constants.Tabbar.Discovery.icon) }
                .addAccessibility(model: Constants.Tabbar.Discovery.accessibility)
            
            WatchlistView()
                .tabItem { Label(Constants.Tabbar.Watchlist.title, image: Constants.Tabbar.Watchlist.icon) }
                .addAccessibility(model: Constants.Tabbar.Discovery.accessibility)
            
            MyTradeMeView()
                .tabItem { Label(Constants.Tabbar.MyTradeMe.title, image: Constants.Tabbar.MyTradeMe.icon) }
                .addAccessibility(model: Constants.Tabbar.Discovery.accessibility)
            
        }
        .tint(.tmBrandPrimary)
        
    }
    
}

#Preview {
    TabBarView()
}
