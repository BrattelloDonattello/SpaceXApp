//
//  HomeView.swift
//  SpaceXTest
//
//  Created by Cristian Ciupac on 15.09.2022.
//

import SwiftUI
import Telescope

struct HomeView: View {
    @EnvironmentObject var vm: SpaceXViewModel
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                List {
                    ForEach(vm.launch) { launch in
                        LaunchCardView(launch: launch)
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    vm.getLaunch()
                }
            } else {
                Image(systemName: "xmark.circle")
                    .foregroundColor(Color.red)
                    .font(.title)
            }
        }
        .navigationTitle("SpaceX")
        .sheet(item: $vm.sheetLaunch) {
            vm.rocket = nil
        } content: { launch in
            LaunchDetailView(launch: launch)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
