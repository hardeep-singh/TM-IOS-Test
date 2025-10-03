//
//  MyTradeMeView.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

struct MyTradeMeView: View {
    var body: some View {
        NavigationStack {
            TMPlaceholderView(title: Constants.MyTradeMe.navTitle)
                .navigationTitle(Constants.MyTradeMe.navTitle)
        }
        
    }
}

#Preview {
    MyTradeMeView()
}
