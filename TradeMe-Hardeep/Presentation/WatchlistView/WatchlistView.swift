
//
//  WatchlistView.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

struct WatchlistView: View {
    var body: some View {
        NavigationStack {
            TMPlaceholderView(title: Constants.WatchlistScreen.navTitle)
                .navigationTitle(Constants.WatchlistScreen.navTitle)
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    WatchlistView()
}
