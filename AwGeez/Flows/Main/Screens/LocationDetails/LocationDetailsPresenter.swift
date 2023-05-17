//
//  LocationDetailsPresenter.swift
//  AwGeez
//
//  Created by Tony Dэ on 16.05.2023.
//  
//

import Foundation
import Model

final class LocationDetailsPresenter {
    
    weak var router: LocationDetailsRouter?
    weak var view: LocationDetailsViewInput?
    private let interactor: LocationDetailsInteractorInput
    
    private let location: Location
    
    lazy var viewModel: LocationDetailsViewModel = makeViewModel()
    
    init(interactor: LocationDetailsInteractorInput, locationId: Location.ID) {
        self.interactor = interactor
        self.location = interactor.location(for: locationId)
    }
}

// MARK: ViewModel building
extension LocationDetailsPresenter {
    private func makeViewModel() -> LocationDetailsViewModel {
        let sections = [detailsSection(), residentsSection()]
        return LocationDetailsViewModel(name: location.name, sections: sections)
    }

    private func detailsSection() -> LocationDetailsViewModel.Section {
        let typeViewModel = LocationDetailsViewModel.Section.Details.type(title: R.string.localizable.type(), type: location.type)
        let dimensionViewModel = LocationDetailsViewModel.Section.Details.dimension(title: R.string.localizable.dimension(), dimension: location.dimension)
        
        let details = [typeViewModel, dimensionViewModel]
        let detailsSection = LocationDetailsViewModel.Section.details(details)
        return detailsSection
    }

    private func residentsSection() -> LocationDetailsViewModel.Section {
        let residents = interactor.characters(for: location.residents)
        let residentsSection = LocationDetailsViewModel.Section.residents(headerTitle: R.string.localizable.residents(), residents: residents)
        return residentsSection
    }
}

extension LocationDetailsPresenter: LocationDetailsViewOutput {
    func didSelectItem(at indexPath: IndexPath) {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .residents(headerTitle: _, residents: let residents):
            let character = residents[indexPath.row]
            router?.showCharacterDetails(for: character.id)
        default: return
        }
    }
}

extension LocationDetailsPresenter: LocationDetailsInteractorOutput {
}
