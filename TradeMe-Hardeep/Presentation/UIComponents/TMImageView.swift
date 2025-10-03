//
//  TMImageView.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

enum UIOImageType: Equatable {
    case remote(URL)
    case local(String)
}

struct TMImageView: View {
    
    let image: UIOImageType
    
    var body: some View {
        switch image {
        case .remote(let url):
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                @unknown default:
                    EmptyView()
                }
            }
        case .local(let name):
            Image(name)
                .resizable()
                .scaledToFill()
        }
    }
    
}
