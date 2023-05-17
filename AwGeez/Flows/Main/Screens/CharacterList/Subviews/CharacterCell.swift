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
    
    private let defaultBackgroundColor = UIColor.white
    private let selectedBackgroundColor = UIColor.lightGray
    
    override func cellDidLoad() {
        super.cellDidLoad()
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
        backgroundColor = .clear
        contentView.addSubview(pictureView)
        contentView.addSubview(descriptionView)
        descriptionView.addSubview(titleLabel)
        descriptionView.addSubview(detailLabel)
        
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
            make.top.right.bottom.equalToSuperview().inset(descriptionView.layoutMargins)
            make.left.equalTo(pictureView.snp.right).offset(descriptionView.layoutMargins.left)
        }
        
        pictureView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(pictureView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
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
        
        let statusString = NSMutableAttributedString(attributedString: viewModel.status.coloredSymbol())
        statusString.append(NSAttributedString(string: " "))
        
        let statusAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
                                NSAttributedString.Key.baselineOffset: NSNumber(value: 2)]
        
        statusString.addAttributes(statusAttributes, range: statusString.mutableString.range(of: statusString.string))
        
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
        let subtitleString = NSAttributedString(string: viewModel.detailSubtitle + ": ", attributes: subtitleAttributes)
        detailtString.append(subtitleString)
        
        let descriptionAttribute = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                    NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .callout)]
        let descriptionString = NSAttributedString(string: viewModel.detailText, attributes: descriptionAttribute)
        
        detailtString.append(descriptionString)
        
        detailLabel.attributedText = detailtString
    }
}
