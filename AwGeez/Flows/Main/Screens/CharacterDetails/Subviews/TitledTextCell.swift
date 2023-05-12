//
//  TitledTextCell.swift
//  AwGeez
//
//  Created by Tony Dэ on 12.05.2023.
//

import UIKit
import SnapKit

class TitledTextCell: TableViewCell {
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    override func cellDidLoad() {
        super.cellDidLoad()
        makeUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
        detailLabel.attributedText = nil
        accessoryType = .none
    }
}

// MARK: Make UI
extension TitledTextCell {
    private func makeUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        
        makeLabels()
        setupLayout()
    }
        
    private func makeLabels() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        titleLabel.textColor = .gray
        
        detailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        detailLabel.numberOfLines = 3
        detailLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.left.top.right.equalTo(contentView.layoutMarginsGuide)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.bottom.right.equalTo(contentView.layoutMarginsGuide)
        }
    }
}
