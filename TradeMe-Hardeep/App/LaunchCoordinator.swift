//
//  LaunchCoordinator.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 04/10/25.
//

import SwiftUI

enum AppLaunchType: String {
    case live
    case mockData = "MockData"
    case unitTests = "UnitTests"
}

class LaunchCoordinator {
    
    private(set) var launchType: AppLaunchType = .live
    
    init() {
        if NSClassFromString("XCTestCase") != nil {
            self.launchType = .unitTests
        } else {
            if let appLaunch = ProcessInfo.processInfo.environment["APP_Launch"],
               let type =  AppLaunchType(rawValue: appLaunch) {
                self.launchType = type
            }
        }
#if DEBUG
        print("🚀 Launch Type: \(launchType.rawValue)")
#endif
    }
    
    @ViewBuilder
    func start() -> some View {
        switch launchType {
        case .live:
            TabBarView(launchType: launchType)
        case .mockData:
            TabBarView(launchType: launchType)
        case .unitTests:
            UnitTestView()
        }
    }
    
}

struct UnitTestView: View {
    
    var body: some View {
        TMPlaceholderView(title: "Unit Tests")
    }
    
}
