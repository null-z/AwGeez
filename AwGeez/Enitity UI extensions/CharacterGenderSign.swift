//
//  CharacterGenderSign.swift
//  AwGeez
//
//  Created by Tony Dэ on 15.05.2023.
//

import UIKit
import Model

extension Character.Gender {
    
    func coloredSign() -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        return NSAttributedString(string: sign, attributes: attributes)
    }
        
    private var color: UIColor {
        switch self {
        case .male: return R.color.gender.male()!
        case .female: return R.color.gender.female()!
        case .genderless: return R.color.gender.genderless()!
        case .unknown: return R.color.gender.unknown()!
        }
    }

    var sign: String {
        switch self {
        case .female: return "♀"
        case .male: return "♂"
        case .genderless: return "∅  " // strange thing, but other characters are indented
        case .unknown: return "?  " // that too
        }
    }
}
