//
//  Container.swift
//  AwGeez
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Swinject

import Api
import RestApi

import Persistence
import RealmPersistence

var container: Container = Container()

extension StartupConfigurator {
    
    func registerDependecies() {
        container.register(Api.self) { _ in RestApi() }
        
        let realmPersistence = RealmPersistence()
        container.register(OverallPersistence.self) { _ in realmPersistence }
        
        container.register((any CharacterDao).self) { _ in realmPersistence.character }
        container.register((any LocationDao).self) { _ in realmPersistence.locaton }
        container.register((any EpisodeDao).self) { _ in realmPersistence.episode }
        
        container.register(Defaults.self) { _ in UserDefaults.standard }
    }
}
