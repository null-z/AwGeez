//
//  CharacterDetailsContract.swift
//  AwGeez
//
//  Created by Tony Dэ on 10.05.2023.
//  
//

import Foundation
import Model

protocol CharacterDetailsRouter: AnyObject {
    func showLocationDetails(for locationID: Location.ID)
    func showEpisodeDetails(for episodeID: Episode.ID)
}

protocol CharacterDetailsInteractorInput: AnyObject {
    func character(for id: Character.ID) -> Character
    func location(for id: Location.ID) -> Location
    func episodes(for ids: [Episode.ID]) -> [Episode]
}

protocol CharacterDetailsInteractorOutput: AnyObject {
}

protocol CharacterDetailsViewInput: AnyObject {
}

protocol CharacterDetailsViewOutput: AnyObject {
    var viewModel: CharacterDetailsViewModel { get }
    func didSelectItem(at indexPath: IndexPath)
}

struct CharacterDetailsViewModel {
    
    let imageUrl: URL
    let name: String
    let sections: [Section]
    
    enum Section {
        case details([Details])
        case episodes(headerTitle: String, episodes: [Episode])
        
        enum Details {
            case status(title: String, status: Character.Status)
            case species(title: String, species: String)
            case gender(title: String, gender: Character.Gender)
            case origin(title: String, location: String)
            case location(title: String, location: String)
        }
        
        var rowCount: Int {
            switch self {
            case .details(let rows): return rows.count
            case .episodes(headerTitle: _, episodes: let rows): return rows.count
            }
        }
    }
}
