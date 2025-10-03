//
//  TradeMe_HardeepApp.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

@main
struct TradeMeApp: App {
    private let coordinator = LaunchCoordinator()
    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
