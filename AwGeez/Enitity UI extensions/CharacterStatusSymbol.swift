//
//  CharacterStatusSymbol.swift
//  AwGeez
//
//  Created by Tony Dэ on 15.05.2023.
//

import UIKit
import Model

extension Character.Status {
    
    func coloredSymbol() -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        return NSAttributedString(string: symbol, attributes: attributes)
    }
    
    private var symbol: String {
        "●"
    }
    
    private var color: UIColor {
        switch self {
        case .alive: return R.color.status.alive()!
        case .dead: return R.color.status.dead()!
        case .unknown: return R.color.status.unknown()!
        }
    }
}
