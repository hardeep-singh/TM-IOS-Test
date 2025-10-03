//
//  LatestListingsView.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

struct LatestListingsView: View {
    
    @ObservedObject var viewModel: LatestListingsViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.listings) { listing in
                ListingRowView(listing: listing, tap: didSelect)
            }
            .listStyle(PlainListStyle())
            .navigationTitle(Constants.DiscoverScreen.navTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationBarButtons(viewModel: viewModel)
                }
            }
            .alert(item: $viewModel.alertItem, content: alert(for:))
            .task {
                await viewModel.fetchListings()
            }
        }
    }
    
    private func alert(for item: AlertItemType) -> Alert {
        let info = item.info()
        return Alert(
            title: Text(info.title),
            message: Text(info.message),
            dismissButton: .default(Text(Constants.ok))
        )
    }
    
    private func didSelect(listing: UIOListing) {
        viewModel.alertItem = .listing
    }
    
}

private struct NavigationBarButtons: View {
    @ObservedObject var viewModel: LatestListingsViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.alertItem = .search
            }) {
                Image(ImageName.search)
            }
            .addAccessibility(model: Constants.DiscoverScreen.searchButton)
            
            Button(action: {
                viewModel.alertItem = .cart
            }) {
                Image(ImageName.cart)
            }
            .addAccessibility(model: Constants.DiscoverScreen.cartButton)
        }
    }
}

#Preview {
    LatestListingsView(viewModel: LatestListingsViewModel())
}

