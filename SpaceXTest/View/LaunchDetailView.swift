//
//  LaunchDetailView.swift
//  SpaceXTest
//
//  Created by Cristian Ciupac on 19.09.2022.
//

import SwiftUI
import YouTubePlayerKit

struct LaunchDetailView: View {
    @EnvironmentObject var vm: SpaceXViewModel
    var launch: Launch
    var youTubePlayer: YouTubePlayer?
    
    init(launch: Launch) {
        self.launch = launch
        
        if let youTubeID = launch.links?.youtube_id {
            youTubePlayer = YouTubePlayer(source: .video(id: youTubeID), configuration: .init(autoPlay: false))
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                if let youTubePlayer = youTubePlayer {
                    YouTubePlayerView(youTubePlayer)
                        .scaledToFit()
                } else {
                    HStack {
                        Text("Some problems starting the player, please try again later.")
                            .font(.body)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Text("\(launch.date_utc.spaceXTime)")
                    .foregroundColor(.gray).opacity(0.8)
                    .padding(.bottom)
                    .font(.headline)
                
                ZStack {
                    if let details = launch.details {
                        ScrollView {
                            Text(details)
                                .foregroundColor(.white).opacity(0.8)
                                .font(.subheadline)
                                .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                    } else {
                        Text("Detatils not available")
                            .foregroundColor(.red).opacity(0.5)
                            .font(.title3)
                    }
                }
                
                VStack(alignment: .center, spacing: 15) {
                    Text("Rocket name: \(vm.rocket?.name ?? "unknown")")
                    Text("Playload mass: \(vm.rocket?.payload_weights?.first?.kg ?? 0) kg")
                }
                .foregroundColor(Color.nameColor)
            }
            .padding(.bottom, 25)
            
            HStack {
                if let wikipediaLink = launch.links?.wikipedia {
                    Link("Wikipedia", destination: URL(string: wikipediaLink)!)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
        }
        .background(Color.mainBG)
        .onAppear {
            vm.getRocket(rocketId: launch.rocket)
        }
    }
}

