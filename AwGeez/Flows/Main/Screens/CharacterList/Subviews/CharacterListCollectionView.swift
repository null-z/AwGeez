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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateCollectionViewLayout(with: collectionView.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewLayout(with: size)
    }
    
    private func updateCollectionViewLayout(with size: CGSize) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.sectionInset = .zero

        let width = size.width
        let numberOfRowsInLine = (width / 100).rounded(.down)
        let side = (width / numberOfRowsInLine)

        layout.itemSize = CGSize(width: side, height: side)
        collectionView.collectionViewLayout = layout
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
