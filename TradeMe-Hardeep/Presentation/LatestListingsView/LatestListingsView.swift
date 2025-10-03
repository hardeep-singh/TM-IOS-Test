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
                ListingRowView(listing: listing, tapOn: didSelect)
            }
            .listStyle(.plain)
            .navigationTitle(Constants.DiscoverScreen.navTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationBarButtons(viewModel: viewModel)
                }
            }
            .alert(item: $viewModel.alertItem, content: alert(for:))
            .task {
                await viewModel.fetchListings()
            }
            .refreshable {
                await viewModel.fetchListings()
            }
        }
    }
    
    private func alert(for item: AlertItemType) -> Alert {
        let info = item.info()
        return Alert(
            title: Text(info.title),
            message: Text(info.message),
            dismissButton: .default(Text(item.buttonTitle()))
        )
    }
    
    private func didSelect(_ type: ListingRowView.ActionType,_ listing: UIOListing) {
        switch type {
        case .row:
            viewModel.alertItem = .listing(listing)
        case .buyNow:
            viewModel.alertItem = .buyNow(listing)
        }
    }
    
}

private struct NavigationBarButtons: View {
    @ObservedObject var viewModel: LatestListingsViewModel
    
    var body: some View {
        HStack {
            Button {
                viewModel.alertItem = .search
            } label: {
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

