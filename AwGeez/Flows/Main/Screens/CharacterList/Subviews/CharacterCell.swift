//
//  CharacterCell.swift
//  AwGeez
//
//  Created by Tony Dэ on 27.04.2023.
//

import UIKit
import Kingfisher

class CharacterCell: TableViewCell {
    
    public static let height: CGFloat = 128
    private let inset: CGFloat = 10
    
    private let pictureView = UIImageView()
    private let descriptionView = UIView()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    
    private let defaultBackgroundColor = R.color.cellBackground()
    private let selectedBackgroundColor = UIColor.lightGray
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(pictureView)
        contentView.addSubview(descriptionView)
        descriptionView.addSubview(titleLabel)
        descriptionView.addSubview(detailLabel)
        makeUI()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        func setSelected() {
            if selected {
                contentView.backgroundColor = selectedBackgroundColor
            } else {
                contentView.backgroundColor = defaultBackgroundColor
            }
        }
        if animated {
            UIView.animate(withDuration: 0.3) {
                setSelected()
            }
        } else {
            setSelected()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: inset / 2, left: inset, bottom: inset / 2, right: inset))
    }
}

// MARK: Make UI
extension CharacterCell {
    private func makeUI() {
        makeContentView()
        makeLabels()
        setupLayout()
    }
    
    private func makeContentView() {
        contentView.backgroundColor = defaultBackgroundColor
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
    }
    
    private func makeLabels() {
        detailLabel.numberOfLines = 3
        detailLabel.lineBreakMode = .byWordWrapping
        
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupLayout() {
        descriptionView.snp.makeConstraints { make in
            let offset = 8
            make.left.equalTo(pictureView.snp.right).offset(offset)
            make.top.equalTo(contentView.snp.top).offset(offset)
            make.right.equalTo(contentView.snp.right).offset(-offset)
            make.bottom.equalTo(contentView.snp.bottom).offset(-offset)
        }
        
        pictureView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(pictureView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(descriptionView.snp.left)
            make.top.equalTo(descriptionView.snp.top)
            make.right.equalTo(descriptionView.snp.right)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.left.equalTo(descriptionView.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
            make.right.equalTo(descriptionView.snp.right)
            make.bottom.lessThanOrEqualTo(descriptionView.snp.bottom)
        }
    }
}

// MARK: Setting up
extension CharacterCell {
    func setup(with viewModel: CharacterItemViewModel) {
        pictureView.kf.setImage(with: viewModel.imageUrl,
                                placeholder: R.image.placeholder())
        setupTitle(viewModel)
        setupDetails(viewModel)
    }
    
    private func setupTitle(_ viewModel: CharacterItemViewModel) {
        let result = NSMutableAttributedString()
        
        let statusAttributes = [NSAttributedString.Key.foregroundColor: viewModel.status.color(),
                                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
                                NSAttributedString.Key.baselineOffset: NSNumber(value: 2)]
        let statusString = NSAttributedString(string: "● ", attributes: statusAttributes)
        result.append(statusString)

        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                               NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title3)]
        let titleString = NSAttributedString(string: viewModel.title, attributes: titleAttributes)
        result.append(titleString)
        
        titleLabel.attributedText = result
    }
    
    private func setupDetails(_ viewModel: CharacterItemViewModel) {
        let detailtString = NSMutableAttributedString()
        
        let subtitleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray,
                                  NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote)]
        let subtitleString = NSAttributedString(string: viewModel.detailSubtitle + " ", attributes: subtitleAttributes)
        detailtString.append(subtitleString)
        
        let descriptionAttribute = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                    NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .callout)]
        let descriptionString = NSAttributedString(string: viewModel.detailText, attributes: descriptionAttribute)
        
        detailtString.append(descriptionString)
        
        detailLabel.attributedText = detailtString
    }
}

import Model

extension Model.Character.Status {
    func color() -> UIColor {
        switch self {
        case .alive: return R.color.status.alive()!
        case .dead: return R.color.status.dead()!
        case .unknown: return R.color.status.unknown()!
        }
    }
}
