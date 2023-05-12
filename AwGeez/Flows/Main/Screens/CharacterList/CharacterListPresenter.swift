//
//  CharacterListPresenter.swift
//  AwGeez
//
//  Created by Tony Dэ on 26.04.2023.
//  
//

import Foundation

final class CharacterListPresenter {
    
    weak var router: CharacterListRouter?
    weak var view: CharacterListViewInput?
    private let interactor: CharacterListInteractorInput
    
    init(interactor: CharacterListInteractorInput) {
        self.interactor = interactor
    }
}

extension CharacterListPresenter: CharacterListViewOutput {
    func title() -> String {
        R.string.localizable.characters_list_title()
    }
    
    func numberOfItems() -> Int {
        interactor.numberOfCharacters()
    }
    
    func imageUrls(for indexes: [Int]) -> [URL] {
        indexes.map { index in
            interactor.character(for: id(for: index)).image
        }
    }
    
    func viewModel(for index: Int) -> CharacterItemViewModel {
        let id = id(for: index)
        let character = interactor.character(for: id)
        let firstEpisode = interactor.episode(for: character.episodes.first!)
        let characterItemViewModel = CharacterItemViewModel(imageUrl: character.image,
                                                            title: character.name,
                                                            status: character.status,
                                                            detailSubtitle: R.string.localizable.first_seen_label(),
                                                            detailText: firstEpisode.name)
        return characterItemViewModel
    }
    
    private func id(for index: Int) -> UInt {
        UInt(exactly: index + 1)!
    }
    
    func didSelectItem(for index: Int) {
        let id = id(for: index)
        router?.showCharacterDetails(for: id)
    }
}

extension CharacterListPresenter: CharacterListInteractorOutput {
}
