//
//  Appearance.swift
//  AwGeez
//
//  Created by Tony Dэ on 16.05.2023.
//

import UIKit

extension StartupConfigurator {
    
    func setupAppearances() {
        makeNavigationTitleFontSizeFitting()
    }
    
    private func makeNavigationTitleFontSizeFitting() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
}
