//
//  MortyViewModel.swift
//  testingApp
//
//  Created by Magdiel G. on 08/06/23.
//

import Foundation
import SwiftUI


final class VewModel: ObservableObject {
    @Published var characterBasicByName: CharacterByName?
    @Published var status: Bool = false
    @Published var viewAlert: Bool = false
    
    func executeRequest(nameV: String) {
        self.status = true
        let chracterURLName = URL(string: "https://rickandmortyapi.com/api/character?name=\(nameV)")!
        print(nameV)
        
        URLSession.shared.dataTask(with: chracterURLName) { [self] data, response, error in
            DispatchQueue.global().async {
                if let data = data {
                    do {
                        let characterByName = try JSONDecoder().decode(CharacterByName.self, from: data)
                        print("Character by Name Model \(characterByName)")
                        
                        DispatchQueue.main.async {
                            self.characterBasicByName = characterByName
                            self.status = false
                        }
                    } catch {
                        DispatchQueue.global().async {
                        print("Error decoding data: \(error)")
                            self.status = false
                            self.viewAlert = true
                        }
                    }
                } else if let error = error {
                    print("Error fetching data: \(error)")
                    self.status = false
                    self.viewAlert = true
                }
            }
        }.resume()

        
//        URLSession.shared.dataTask(with: chracterURL) { data, response, error in
//            let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data!)
//            print("Character Model \(characterModel.name)")
//
//
//            let firstEpisode = URL(string: characterModel.episode.first!)!
//            URLSession.shared.dataTask(with: firstEpisode) { data, response, error in
//                let espiodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: data!)
//                print("Episode Model \(espiodeModel)")
//
//                let characterEpisodeoModelUrl = URL(string: characterModel.locationUrl)!
//
//                URLSession.shared.dataTask(with: characterEpisodeoModelUrl) {locationData, response, error in
//                    let locationModel = try! JSONDecoder().decode(LocationModel.self, from: locationData!)
//                    print("Location Model \(locationModel)")
//                    DispatchQueue.main.async {
//                        self.characterBasicInfor = .init(name: characterModel.name, image: URL(string: characterModel.image)!, firstEpisodeTitle: espiodeModel.name, dimension: locationModel.dimension
//                        )
//                    }
//                }.resume()
//
//            }.resume()
//
//        }.resume()
    }
}
