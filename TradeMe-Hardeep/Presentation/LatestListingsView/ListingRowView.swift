//
//  ListingRowView.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI
import SwiftUI

struct ListingRowView: View {
    
    let listing: UIOListing
    private let tapOn: (ActionType, UIOListing) -> Void
    
    enum ActionType {
        case row
        case buyNow
    }
    private enum Layout {
        static let cellHeight: CGFloat = 100
        static let imageCornerRadius: CGFloat = 8
        static let rowSpacing: CGFloat = 12
    }
    
    init(listing: UIOListing, tapOn: @escaping  (ActionType, UIOListing) -> Void) {
        self.listing = listing
        self.tapOn = tapOn
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: Layout.rowSpacing) {
            
            TMImageView(image: listing.thumbnil)
                .frame(width: Layout.cellHeight, height: Layout.cellHeight)
                .background(Color.gray.opacity(0.6))
                .cornerRadius(Layout.imageCornerRadius)
                .clipped()
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(listing.location)
                    .font(.tmSubtitle1)
                    .foregroundColor(.tmTextLight)
                    .lineLimit(2)
                    .addAccessibility(model: Constants.DiscoverScreenRow.locationAccessibility,
                                      value: listing.location)
                
                Text(listing.title)
                    .font(.tmTitle1)
                    .foregroundColor(.tmTextDark)
                    .lineLimit(2)
                    .addAccessibility(model: Constants.DiscoverScreenRow.titleAccessibility,
                                      value: listing.title)
                
                Spacer()
                priceSection(for: listing)
            }
            .frame(height: Layout.cellHeight, alignment: .top)
        }
        .contentShape(Rectangle())
        .onTapGesture { tapOn( .row, listing) }
        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
    }
    
    // MARK: - Price Section
    @ViewBuilder
    private func priceSection(for listing: UIOListing) -> some View {
        
        HStack(alignment: .bottom) {
            if let displayPrice = listing.displayPrice {
                VStack(alignment: .leading) {
                    titleLabel(text: displayPrice.header)
                    if let subheader = displayPrice.subheader {
                        subtitleLabel(text: subheader)
                    }
                }
            }
            Spacer()
            if let buyNow = listing.buyNowPrice {
                buyNowButton(buyNowPrice: buyNow)
            }
        }
    }
    
    // MARK: - Components
    private func buyNowButton(buyNowPrice: String) -> some View {
        Button {
            tapOn(.buyNow, self.listing)
        } label: {
            VStack(alignment: .trailing, spacing: 2) {
                titleLabel(text: buyNowPrice)
                subtitleLabel(text: Constants.DiscoverScreenRow.buyNow)
            }
        }
        .buttonStyle(.plain)
        .addAccessibility(model: Constants.DiscoverScreenRow.buyNowAccessibility, value: buyNowPrice)
    }
    
    private func titleLabel(text: String) -> some View {
        Text(text)
            .font(.tmTitle2)
            .lineLimit(1)
            .foregroundColor(.tmTextDark)
    }
    
    private func subtitleLabel(text: String) -> some View {
        Text(text)
            .font(.tmSubtitle1)
            .lineLimit(1)
            .foregroundColor(.tmTextLight)
    }
    
}


