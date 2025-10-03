//
//  TabbarView.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

struct TabBarView: View {
    
    let launchType: AppLaunchType
    
    var body: some View {
        TabView {
            
            LatestListingsView(viewModel: makeLatestListingsViewModel())
                .tabItem { Label(Constants.Tabbar.Discovery.title, image: Constants.Tabbar.Discovery.icon) }
                .addAccessibility(model: Constants.Tabbar.Discovery.accessibility)
            
            WatchlistView()
                .tabItem { Label(Constants.Tabbar.Watchlist.title, image: Constants.Tabbar.Watchlist.icon) }
                .addAccessibility(model: Constants.Tabbar.Watchlist.accessibility)
            
            MyTradeMeView()
                .tabItem { Label(Constants.Tabbar.MyTradeMe.title, image: Constants.Tabbar.MyTradeMe.icon) }
                .addAccessibility(model: Constants.Tabbar.MyTradeMe.accessibility)
        }
        .tint(.tmBrandPrimary)
        
    }
    
    private func makeLatestListingsViewModel() -> LatestListingsViewModel {
        if launchType == .live {
            let client = HTTPClientImp()
            let loader = RemoteListingsLoader(httpClient: client)
            return LatestListingsViewModel(listingsLoader: loader)
        } else {
            return MockListingsViewModel()
        }
    }
}

#Preview {
    TabBarView(launchType: .mockData)
}
