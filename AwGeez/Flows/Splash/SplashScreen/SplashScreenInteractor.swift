//
//  SplashScreenInteractor.swift
//  AwGeez
//
//  Created by Tony Dэ on 23.04.2023.
//

import Foundation
import Swinject
import Api
import Persistence

final class SplashScreenInteractor {
    
    weak var presenter: SplashScreenInteractorOutput?
    
    private var api: Api = container.resolve(Api.self)!
    private var persistence: OverallPersistence = container.resolve(OverallPersistence.self)!
    private var defaults: Defaults = container.resolve(Defaults.self)!
    
    private let daysToUpdate = 7
}

extension SplashScreenInteractor: SplashScreenInteractorInput {
    func updateDataIfNeeded() {
        
        guard needsToUpdate() == true else {
            presenter?.dataDidUpdated()
            return
        }
        
        self.persistence.clear()
        
        api.getAll { [weak self] entities in
            guard let self else { return }
            self.persistence.fillWith(characters: entities.characters,
                                      locations: entities.locations,
                                      episodes: entities.episodes)
            self.defaults.lastUpdateDate = Date()
            self.presenter?.dataDidUpdated()
        } failure: { [weak self] error in
            guard let self else { return }
            self.presenter?.dataUpdateError(error)
        }
    }
    
    private func needsToUpdate() -> Bool {
        let isPersistenceEmpty = !persistence.isFilled
        return isDaysToUpdateExpired() || isPersistenceEmpty
    }
    
    private func isDaysToUpdateExpired() -> Bool {
        guard let lastUpdateDate = defaults.lastUpdateDate else {
            return true
        }
        let daysFromLastUpdate = daysFrom(date: lastUpdateDate)
        return daysFromLastUpdate >= daysToUpdate
    }
    
    private func daysFrom(date: Date) -> Int {
        let calendar = Calendar.current
        
        let firstDate = calendar.startOfDay(for: date)
        let secondDate = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: firstDate, to: secondDate)
        return components.day ?? 0
    }
}
