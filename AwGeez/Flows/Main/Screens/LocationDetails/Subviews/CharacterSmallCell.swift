//
//  CharacterSmallCell.swift
//  AwGeez
//
//  Created by Tony Dэ on 16.05.2023.
//

import UIKit
import SnapKit
import Kingfisher
import Model

class CharacterSmallCell: TableViewCell {
    
    private let pictureView = UIImageView()
    private let nameLabel = UILabel()
    
    override func cellDidLoad() {
        super.cellDidLoad()
        makeUI()
    }
}

// MARK: Make UI
extension CharacterSmallCell {
    private func makeUI() {
        contentView.addSubview(pictureView)
        contentView.addSubview(nameLabel)
        
        contentView.backgroundColor = .white
        
        pictureView.layer.cornerRadius = 5
        pictureView.clipsToBounds = true
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byTruncatingTail
        
        setupLayout()
    }
            
    private func setupLayout() {
        pictureView.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.verticalEdges.equalToSuperview().halfInset()
            make.left.equalTo(contentView.layoutMarginsGuide)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(pictureView)
            make.left.equalTo(pictureView.snp.right).smallOffset()
            make.right.equalTo(contentView.layoutMarginsGuide)
        }
    }
}

// MARK: Setting up
extension CharacterSmallCell {
    func setup(with viewModel: Character) {
        pictureView.kf.setImage(with: viewModel.image,
                                placeholder: R.image.placeholder())
        nameLabel.text = viewModel.name
    }
}

extension ConstraintMakerEditable {
    
// MARK: Inset
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
    
// MARK: Offset
    @discardableResult
    func smallOffset() -> ConstraintMakerEditable {
        offset(8)
    }
    
    @discardableResult
    func mediumOffset() -> ConstraintMakerEditable {
        offset(16)
    }
}
