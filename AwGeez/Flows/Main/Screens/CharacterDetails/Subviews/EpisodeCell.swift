//
//  EpisodeCell.swift
//  AwGeez
//
//  Created by Tony Dэ on 15.05.2023.
//

import Foundation

import UIKit
import SnapKit

class EpisodeCell: TableViewCell {
    
    let numbersLabel = UILabel()
    let nameLabel = UILabel()
    private let stackView = UIStackView()
    
    override func cellDidLoad() {
        super.cellDidLoad()
        makeUI()
    }
}

// MARK: Make UI
extension EpisodeCell {
    private func makeUI() {
        contentView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.addArrangedSubview(numbersLabel)
        stackView.addArrangedSubview(nameLabel)
        
        makeLabels()
        setupLayout()
    }
        
    private func makeLabels() {
        numbersLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        numbersLabel.textColor = .white
        numbersLabel.numberOfLines = 2
        numbersLabel.backgroundColor = .lightGray
        numbersLabel.lineBreakMode = .byWordWrapping
        numbersLabel.textAlignment = .center
        numbersLabel.layer.cornerRadius = 5
        numbersLabel.clipsToBounds = true
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.numberOfLines = 3
        nameLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
        
        numbersLabel.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
    }
}
