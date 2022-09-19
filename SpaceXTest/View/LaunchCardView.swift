//
//  LaunchCardView.swift
//  SpaceXTest
//
//  Created by Cristian Ciupac on 19.09.2022.
//

import SwiftUI
import Telescope

struct LaunchCardView: View {
    @EnvironmentObject var vm: SpaceXViewModel
    
    var launch: Launch
    var imageURL: String?
    var usePatch = Bool()
    
    init(launch: Launch) {
        self.launch = launch
        
        guard let flickrLink = launch.links?.flicker.original.first else {
            guard let patchLink = launch.links?.patch.large else {
                self.imageURL = nil
                return
            }
            usePatch = true
            self.imageURL = patchLink
            return
        }
        self.imageURL = flickrLink
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            VStack {
                HStack {
                    if let imageURL = imageURL {
                        if !usePatch {
                            TImage(try? RemoteImage(stringURL: imageURL))
                                .resizable()
                        } else {
                            TImage(try? RemoteImage(stringURL: imageURL))
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, 12)
                                .padding(.bottom, 64)
                        }
                    } else {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.red)
                            .font(.title)
                    }
                }
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: "#BABEBD"), lineWidth: 2)
                )
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.001)))
                .cornerRadius(10)
            
            
            HStack {
                Text("\(launch.name)")
                    .foregroundColor(Color.nameColor)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                Spacer()
                Text("\(launch.date_utc.spaceXTime)")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 3)
                    .foregroundColor(.white)
                    .background(Color.timeBGColor)
            }
            .padding(.horizontal)
            }
        }
        .onTapGesture {
            vm.sheetLaunch = launch
        }
    }
}
