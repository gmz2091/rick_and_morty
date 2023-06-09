//
//  ResponseMortyModel.swift
//  testingApp
//
//  Created by Magdiel G. on 08/06/23.
//
import Foundation

struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let image: String
    let episode: [String]
    let locationName: String
    let locationUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case episode
        case location
        case locationUrl = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CharacterModel.CodingKeys> = try decoder.container(keyedBy: CharacterModel.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: CharacterModel.CodingKeys.id)
        self.name = try container.decode(String.self, forKey: CharacterModel.CodingKeys.name)
        self.image = try container.decode(String.self, forKey: CharacterModel.CodingKeys.image)
        self.episode = try container.decode([String].self, forKey: CharacterModel.CodingKeys.episode)
        
        let locationContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        self.locationName = try locationContainer.decode(String.self, forKey: .name)
        self.locationUrl = try locationContainer.decode(String.self, forKey: .locationUrl)
    }
}


struct EpisodeModel: Decodable {
    let id: Int
    let name: String
}

struct LocationModel: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
}


struct CharacterBasicInfo: Decodable {
    let name: String
    let image: URL?
    let firstEpisodeTitle: String
    let dimension: String
    
    static var empty: Self {
        .init(name: "", image: nil, firstEpisodeTitle: "", dimension: "")
    }
}

// MARK: - Morty
struct CharacterByName: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let id: Int
    var name: String
    var status: Status
    var species: Species
    var gender: Gender
    var image: String
    let url: String
    var created: String
}

enum Gender: String, Decodable {
    case male = "Male"
    case unknown = "unknown"
}

enum Species: String, Decodable {
    case alien = "Alien"
    case cronenberg = "Cronenberg"
    case human = "Human"
    case humanoid = "Humanoid"
}

enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
