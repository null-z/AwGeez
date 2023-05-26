//
//  CollectionViewController.swift
//  AwGeez
//
//  Created by Tony Dэ on 23.05.2023.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
        
    @available(*, unavailable, message: "Nib are unsupported")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
