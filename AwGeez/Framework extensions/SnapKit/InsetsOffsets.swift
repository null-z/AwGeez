//
//  InsetsOffsets.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.05.2023.
//

import SnapKit

// MARK: Inset
extension ConstraintMakerEditable {
    @discardableResult
    func halfInset() -> ConstraintMakerEditable {
        inset(4)
    }
    
    @discardableResult
    func smallInset() -> ConstraintMakerEditable {
        inset(8)
    }
    
    @discardableResult
    func mediumInset() -> ConstraintMakerEditable {
        inset(16)
    }
}

// MARK: Offset
extension ConstraintMakerEditable {
    @discardableResult
    func smallOffset() -> ConstraintMakerEditable {
        offset(8)
    }
    
    @discardableResult
    func mediumOffset() -> ConstraintMakerEditable {
        offset(16)
    }
}
