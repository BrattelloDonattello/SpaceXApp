//
//  SpaceXTestApp.swift
//  SpaceXTest
//
//  Created by Cristian Ciupac on 15.09.2022.
//

import SwiftUI

@main
struct SpaceXTestApp: App {
    @StateObject private var vm = SpaceXViewModel()
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .environmentObject(vm)
        }
    }
}
