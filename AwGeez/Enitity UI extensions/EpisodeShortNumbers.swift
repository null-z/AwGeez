//
//  EpisodeShortNumbers.swift
//  AwGeez
//
//  Created by Tony Dэ on 15.05.2023.
//

import Model

extension Episode {
    
    func shortNumbers() -> String {
        "S" + String(season) + "\n" + "E" + String(number)
    }
}
