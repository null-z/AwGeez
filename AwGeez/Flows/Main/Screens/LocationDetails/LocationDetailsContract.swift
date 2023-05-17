//
//  LocationDetailsContract.swift
//  AwGeez
//
//  Created by Tony Dэ on 16.05.2023.
//  
//

import Foundation
import Model

protocol LocationDetailsRouter: AnyObject {
    func showCharacterDetails(for characterId: Character.ID)
}

protocol LocationDetailsInteractorInput: AnyObject {
    func location(for id: Location.ID) -> Location
    func characters(for ids: [Character.ID]) -> [Character]
}

protocol LocationDetailsInteractorOutput: AnyObject {
}

protocol LocationDetailsViewInput: AnyObject {
}

protocol LocationDetailsViewOutput: AnyObject {
    var viewModel: LocationDetailsViewModel { get }
    func didSelectItem(at indexPath: IndexPath)
}

struct LocationDetailsViewModel {
    let name: String
    let sections: [Section]
    
    enum Section {
        case details([Details])
        case residents(headerTitle: String, residents: [Character])
        
        enum Details {
            case type(title: String, type: String)
            case dimension(title: String, dimension: String)
        }
        
        var rowCount: Int {
            switch self {
            case .details(let rows): return rows.count
            case .residents(headerTitle: _, residents: let rows): return rows.count
            }
        }
    }
}
