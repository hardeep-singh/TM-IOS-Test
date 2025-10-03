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
            
            LatestListingsView(viewModel: makeLatestListingsViewModel())
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

private func makeLatestListingsViewModel() -> LatestListingsViewModel {
    if let mock = ProcessInfo.processInfo.environment["MOCK-DATA"], mock == "TRUE" {
        return MockListingsViewModel()
    } else {
        return LatestListingsViewModel()
    }
}

#Preview {
    TabBarView()
}
