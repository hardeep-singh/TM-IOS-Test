//
//  LatestListingsView.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

struct LatestListingsView: View {
    
    var body: some View {
        NavigationStack {
            TMPlaceholderView(title: Constants.DiscoverScreen.navTitle)
                .navigationTitle(Constants.DiscoverScreen.navTitle)
        }
    }
    
}

#Preview {
    LatestListingsView()
}
