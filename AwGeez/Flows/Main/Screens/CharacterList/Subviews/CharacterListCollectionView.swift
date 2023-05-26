//
//  CharacterListCollectionView.swift
//  AwGeez
//
//  Created by Tony Dэ on 23.05.2023.
//

import UIKit

class CharacterListCollectionView: CollectionViewController {
    
    private let presenter: CharacterListViewOutput
    
    init(presenter: CharacterListViewOutput) {
        self.presenter = presenter
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.prefetchDataSource = self
        makeUI()
    }
}

// MARK: CollectionView FlowLayout
extension CharacterListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfRowsInLine = (width / 100).rounded(.down)
        let side = (width / numberOfRowsInLine)

        return CGSize(width: side, height: side)
    }
}

// MARK: CollectionView 
extension CharacterListCollectionView {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ImageCell.self, for: indexPath)
        cell.setImage { [weak self] in
            guard let self else { return nil }
            return self.presenter.imageUrl(for: indexPath.row)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(for: indexPath.row)
    }
}

// MARK: Prefetch
extension CharacterListCollectionView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            let indexes = indexPaths.map { $0.row }
            let urls = self.presenter.imageUrls(for: indexes)
            ImageLoader.prefetchImages(for: urls)
        }
    }
}

// MARK: Make UI
extension CharacterListCollectionView {
    private func makeUI() {
        navigationItem.largeTitleDisplayMode = .always
        title = presenter.title()
        collectionView.backgroundColor = nil
        
        setupLayout()
    }
    
    private func setupLayout() {
    }
}

// MARK: ViewInput
extension CharacterListCollectionView: CharacterListViewInput {
}
