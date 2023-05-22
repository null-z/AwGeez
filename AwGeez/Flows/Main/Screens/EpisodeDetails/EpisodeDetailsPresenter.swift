//
//  EpisodeDetailsPresenter.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.05.2023.
//  
//

import Foundation
import Model

final class EpisodeDetailsPresenter {
    
    weak var router: EpisodeDetailsRouter?
    weak var view: EpisodeDetailsViewInput?
    private let interactor: EpisodeDetailsInteractorInput
    
    private let episode: Episode
    
    lazy var viewModel: EpisodeDetailsViewModel = makeViewModel()
    
    private let dateFormatter = DateFormatter()
    
    init(interactor: EpisodeDetailsInteractorInput, episodeId: Episode.ID) {
        self.interactor = interactor
        self.episode = interactor.episode(for: episodeId)
        dateFormatter.dateFormat = "MMMM d, yyyy"
    }
}

// MARK: ViewModel building
extension EpisodeDetailsPresenter {
    private func makeViewModel() -> EpisodeDetailsViewModel {
        let sections = [detailsSection(), charactersSection()]
        return EpisodeDetailsViewModel(title: episode.name, sections: sections)
    }

    private func detailsSection() -> EpisodeDetailsViewModel.Section {
        let seasonViewModel = EpisodeDetailsViewModel.Section.Details.season(text: R.string.localizable.season() + " " + String(episode.season))
        let episodeViewModel = EpisodeDetailsViewModel.Section.Details.episode(text: R.string.localizable.episode() + " " + String(episode.number))
        let airDateViewModel = EpisodeDetailsViewModel.Section.Details.airDate(title: R.string.localizable.air_date(), airDate: dateFormatter.string(from: episode.airDate))
                
        let details = [seasonViewModel, episodeViewModel, airDateViewModel]
        let detailsSection = EpisodeDetailsViewModel.Section.details(details)
        return detailsSection
    }

    private func charactersSection() -> EpisodeDetailsViewModel.Section {
        let characters = interactor.characters(for: episode.characters)
        let charactersSection = EpisodeDetailsViewModel.Section.characters(headerTitle: R.string.localizable.characters_list_title(), characters: characters)
        return charactersSection
    }
}

extension EpisodeDetailsPresenter: EpisodeDetailsViewOutput {
    func didSelectItem(at indexPath: IndexPath) {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .characters(headerTitle: _, characters: let characters):
            let character = characters[indexPath.row]
            router?.showCharacterDetails(for: character.id)
        default: return
        }
    }
    
    func imageUrls(for indexPaths: [IndexPath]) -> [URL] {
        indexPaths.compactMap { indexPath in
            let section = viewModel.sections[indexPath.section]
            switch section {
            case .characters(headerTitle: _, characters: let characters):
                let character = characters[indexPath.row]
                return character.image
            default: return nil
            }
        }
    }
}

extension EpisodeDetailsPresenter: EpisodeDetailsInteractorOutput {
}
