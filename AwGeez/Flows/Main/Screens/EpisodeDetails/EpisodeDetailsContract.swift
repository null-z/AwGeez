//
//  EpisodeDetailsContract.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.05.2023.
//  
//

import Foundation
import Model

protocol EpisodeDetailsRouter: AnyObject {
    func showCharacterDetails(for characterId: Character.ID)
}

protocol EpisodeDetailsInteractorInput: AnyObject {
    func episode(for id: Episode.ID) -> Episode
    func characters(for ids: [Character.ID]) -> [Character]
}

protocol EpisodeDetailsInteractorOutput: AnyObject {
}

protocol EpisodeDetailsViewInput: AnyObject {
}

protocol EpisodeDetailsViewOutput: AnyObject {
    var viewModel: EpisodeDetailsViewModel { get }
    func didSelectItem(at indexPath: IndexPath)
    func imageUrls(for indexPaths: [IndexPath]) -> [URL]
}

struct EpisodeDetailsViewModel {
    let title: String
    let sections: [Section]
    
    enum Section {
        case details([Details])
        case characters(headerTitle: String, characters: [Character])
        
        enum Details {
            case season(text: String)
            case episode(text: String)
            case airDate(title: String, airDate: String)
        }
        
        var rowCount: Int {
            switch self {
            case .details(let rows): return rows.count
            case .characters(headerTitle: _, characters: let rows): return rows.count
            }
        }
    }
}
