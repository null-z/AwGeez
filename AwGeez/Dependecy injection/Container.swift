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

func registerDependecies() {
    container.register(Api.self) { _ in RestApi() }
    
    let realmPersistence = RealmPersistence()
    container.register(OverallPersistence.self) { _ in realmPersistence }
    
    container.register(Defaults.self) { _ in UserDefaults.standard }
}
