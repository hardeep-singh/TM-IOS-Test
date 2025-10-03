//
//  LatestListingsViewModel.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import Foundation
import Combine

enum AlertType: String, Identifiable {
    case cart
    case search
    case listing
    
    var id: String {
        self.rawValue
    }
}

class LatestListingsViewModel: ObservableObject {
    @Published var listings: [UIOListing] = []
    @Published var alertItem: AlertType?
    
    init() {
      
    }
    
    func fetchListings() async {
    
    }
    
}
