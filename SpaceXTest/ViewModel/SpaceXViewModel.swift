//
//  SpaceXViewModel.swift
//  SpaceXTest
//
//  Created by Cristian Ciupac on 15.09.2022.
//

import Foundation
import Combine

class SpaceXViewModel: ObservableObject {
    
    @Published var launch = [Launch]()
    @Published var loadingError = Bool()
    @Published var sheetLaunch: Launch? = nil
    @Published var rocket: Rocket?
    
    var cancellables: AnyCancellable?
    
    var isLoading: Bool {
        !launch.isEmpty && !loadingError
    }
    
    init() {
        getLaunch()
    }
    
    func getLaunch() {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap(handleOutput)
            .decode(type: [Launch].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.loadingError = true
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] returnedLaunch in
                self?.launch = returnedLaunch
                self?.loadingError = false
            })

    }
    
    func getRocket(rocketId: String) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets/\(rocketId)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap(handleOutput)
            .decode(type: Rocket.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.loadingError = true
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] returnedRocket in
                self?.rocket = returnedRocket
                self?.loadingError = false
            })
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}
