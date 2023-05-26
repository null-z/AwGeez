//
//  ImageCell.swift
//  AwGeez
//
//  Created by Tony Dэ on 23.05.2023.
//

import UIKit
import Kingfisher

class ImageCell: CollectionViewCell {
    
    typealias ImageUrlFetch = () -> URL?
    
    private let imageView = UIImageView()
    
    private var imageUrlFetchOperation: Operation?
    
    override func cellDidLoad() {
        super.cellDidLoad()
        makeUI()
    }
    
    func setImage(url: URL) {
        imageView.setImage(with: url)
    }
    
    func setImage(with imageUrlFetch: @escaping ImageUrlFetch) {
        imageView.image = R.image.placeholder()
        imageUrlFetchOperation = UrlFetchOperation(imageUrlFetch) { [weak self] url in
            guard let self else { return }
            self.imageView.setImage(with: url)
        }
        imageUrlFetchOperation?.start()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageUrlFetchOperation?.cancel()
    }
}

// MARK: Make UI
extension ImageCell {
    private func makeUI() {
        backgroundColor = .clear
        contentView.addSubview(imageView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: UrlFetchOperation
class UrlFetchOperation: Operation {
    
    typealias Fetching = () -> URL?
    typealias Completion = (_ url: URL) -> Void
    
    private let fetching: Fetching
    private let completion: Completion
    
    private var isLoadFinished = false
    
    init(_ fetching: @escaping Fetching, _ completion: @escaping Completion) {
        self.fetching = fetching
        self.completion = completion
    }
    
    override func start() {
        super.start()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            let url = self.fetching()
            
            DispatchQueue.main.async { [weak self] in
                guard let self, let url else { return }
                guard !self.isCancelled else { return }
                
                self.completion(url)
                self.isLoadFinished = true
            }
        }
    }
    
    override var isFinished: Bool {
        isLoadFinished
    }
}
