//
//  View.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.03.2023.
//

import UIKit

class View: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "Nib are unsupported")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
