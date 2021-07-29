//
//  F1HistoryApp.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/7/21.
//

import SwiftUI

@main
struct F1HistoryApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView()
            //SeasonsCoordinator.navigation()
            //DriversCoordinator.navigation()
            //ConstructorsCoordinator.navigation()
            CircuitsCoordinator.buildView()
        }
    }
}
