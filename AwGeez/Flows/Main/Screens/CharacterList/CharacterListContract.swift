//
//  CharacterListContract.swift
//  AwGeez
//
//  Created by Tony Dэ on 26.04.2023.
//  
//

import Foundation
import Model

protocol CharacterListRouter: AnyObject {
    func showCharacterDetails(for characterId: Character.ID)
}

protocol CharacterListInteractorInput: AnyObject {
    func numberOfCharacters() -> Int
    func character(for id: Character.ID) -> Character
    func episode(for id: Episode.ID) -> Episode
}

protocol CharacterListInteractorOutput: AnyObject {
}

protocol CharacterListViewInput: AnyObject {
}

protocol CharacterListViewOutput: AnyObject {
    func title() -> String
    func numberOfItems() -> Int
    func imageUrl(for index: Int) -> URL
    func imageUrls(for indexes: [Int]) -> [URL]
    func viewModel(for index: Int) -> CharacterItemViewModel
    func didSelectItem(for index: Int)
}

struct CharacterItemViewModel {
    let imageUrl: URL
    let title: String
    let status: Character.Status
    let detailSubtitle: String
    let detailText: String
}
