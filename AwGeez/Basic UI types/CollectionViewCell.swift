//
//  CollectionViewCell.swift
//  AwGeez
//
//  Created by Tony Dэ on 23.05.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellDidLoad()
    }
    
    /// Called after cell is initialized
    func cellDidLoad() {
    }
    
    @available(*, unavailable, message: "Nib are unsupported")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: CollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: type.self)
        self.register(T.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
        return self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T // swiftlint:disable:this force_cast
    }
}
