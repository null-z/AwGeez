//
//  CharacterDetailsPresenter.swift
//  AwGeez
//
//  Created by Tony Dэ on 10.05.2023.
//  
//

import Foundation
import Model

final class CharacterDetailsPresenter {
    
    weak var router: CharacterDetailsRouter?
    weak var view: CharacterDetailsViewInput?
    private let interactor: CharacterDetailsInteractorInput
    
    private let character: Character
    
    lazy var viewModel: CharacterDetailsViewModel = makeViewModel()
    
    init(interactor: CharacterDetailsInteractorInput, characterId: Character.ID) {
        self.interactor = interactor
        self.character = interactor.character(for: characterId)
    }
        
}

// MARK: ViewModel building
extension CharacterDetailsPresenter {
    
    private func makeViewModel() -> CharacterDetailsViewModel {
        let sections = [detailsSection(for: character), episodesSection(for: character)]
        
        return CharacterDetailsViewModel(imageUrl: character.image, name: character.name, sections: sections)
    }
    
    private func detailsSection(for character: Character) -> CharacterDetailsViewModel.Section {
        var details = [CharacterDetailsViewModel.Section.Details]()
        
        let statusViewModel = CharacterDetailsViewModel.Section.Details.status(title: R.string.localizable.status(), status: character.status)
        let speciesViewModel = CharacterDetailsViewModel.Section.Details.species(title: R.string.localizable.species(), species: speciesString(for: character))
        let genderViewModel = CharacterDetailsViewModel.Section.Details.gender(title: R.string.localizable.gender(), gender: character.gender)
        
        details.append(contentsOf: [statusViewModel, speciesViewModel, genderViewModel])
        
        if let originId = character.origin {
            let origin = interactor.location(for: originId)
            let originViewModel = CharacterDetailsViewModel.Section.Details.origin(title: R.string.localizable.origin_location(), location: origin.name)
            details.append(originViewModel)
        }
        
        if let locationID = character.location {
            let location = interactor.location(for: locationID)
            let locationViewModel = CharacterDetailsViewModel.Section.Details.location(title: R.string.localizable.last_known_location(), location: location.name)
            details.append(locationViewModel)
        }
        
        return CharacterDetailsViewModel.Section.details(details)
    }

    private func speciesString(for character: Character) -> String {
        var result = character.species
        if let type = character.type {
            result = result + " - " + type
        }
        return result
    }
    
    private func episodesSection(for character: Character) -> CharacterDetailsViewModel.Section {
        let episodes = interactor.episodes(for: character.episodes)
        return CharacterDetailsViewModel.Section.episodes(headerTitle: R.string.localizable.starred_in_episodes(), episodes: episodes)
    }
}

extension CharacterDetailsPresenter: CharacterDetailsViewOutput {
    func didSelectItem(at indexPath: IndexPath) {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .details(let details):
            
            let detail = details[indexPath.row]
            switch detail {
            case .origin(title: _, location: _):
                router?.showLocationDetails(for: character.origin!)
            case .location(title: _, location: _):
                router?.showLocationDetails(for: character.location!)
            default: return
            }
            
        case .episodes(headerTitle: _, episodes: let episodes):
            let episode = episodes[indexPath.row]
            router?.showEpisodeDetails(for: episode.id)
        }
    }
}

extension CharacterDetailsPresenter: CharacterDetailsInteractorOutput {
}
