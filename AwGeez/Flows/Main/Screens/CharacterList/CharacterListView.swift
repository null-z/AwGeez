//
//  CharacterListView.swift
//  AwGeez
//
//  Created by Tony Dэ on 25.05.2023.
//

import UIKit

class CharacterListView: ViewController {
    
    private let presenter: CharacterListViewOutput
    
    private var style = Style.table
    private let switchStyleButton = UIBarButtonItem()
    private lazy var tableViewController = CharacterListTableView(presenter: self)
    private lazy var collectionViewController = CharacterListCollectionView(presenter: self)
    
    init(presenter: CharacterListViewOutput) {
        self.presenter = presenter
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
}

// MARK: Make UI
extension CharacterListView {
    private func makeUI() {
        navigationItem.largeTitleDisplayMode = .always
        title = presenter.title()
        addGradient()
        makeSwitchViewStyleButton()
        updateViewForCurrentStyle()
        
        setupLayout()
    }
    
    private func addGradient() {
        let gradientView = GradientView()
        gradientView.colors = [UIColor.white, UIColor.lightGray]
        view = gradientView
    }
    
    private func makeSwitchViewStyleButton() {
        switchStyleButton.style = .plain
        switchStyleButton.tintColor = R.color.portal()
        switchStyleButton.target = self
        switchStyleButton.action = #selector(switchStyleButtonAction(_ :))
        navigationItem.setRightBarButton(switchStyleButton, animated: true)
    }
    
    private func setupLayout() {
    }
}

// MARK: Switch view style
private extension CharacterListView {
    
    enum Style {
        case table
        case collection
        
        var image: UIImage {
            let image: UIImage?
            switch self {
            case .table: image = UIImage(systemName: "rectangle.grid.1x2.fill")
            case .collection: image = UIImage(systemName: "square.grid.3x2.fill")
            }
            return image ?? R.image.portal()!
        }
    }
    
    @objc
    private func switchStyleButtonAction(_ sender: UIBarButtonItem) {
        switchStyle()
        updateViewForCurrentStyle()
    }
    
    private func switchStyle() {
        switch style {
        case .table: style = .collection
        case .collection: style = .table
        }
    }
    
    private func updateViewForCurrentStyle() {
        switch style {
        case .table:
            switchStyleButton.image = Style.collection.image
            replace(viewController: collectionViewController, with: tableViewController, animated: true)
            tableViewController.syncScrollPosition(with: collectionViewController)
        case .collection:
            switchStyleButton.image = Style.table.image
            replace(viewController: tableViewController, with: collectionViewController, animated: true)
            collectionViewController.syncScrollPosition(with: tableViewController)
        }
    }
}

// MARK: ViewInput
extension CharacterListView: CharacterListViewOutput {
    
    func title() -> String {
        presenter.title()
    }
    
    func numberOfItems() -> Int {
        presenter.numberOfItems()
    }
    
    func imageUrl(for index: Int) -> URL {
        presenter.imageUrl(for: index)
    }
    
    func imageUrls(for indexes: [Int]) -> [URL] {
        presenter.imageUrls(for: indexes)
    }
    
    func viewModel(for index: Int) -> CharacterItemViewModel {
        presenter.viewModel(for: index)
    }
    
    func didSelectItem(for index: Int) {
        presenter.didSelectItem(for: index)
    }
}

// MARK: ViewInput
extension CharacterListView: CharacterListViewInput {
}

// MARK: ScrollSyncable
extension ScrollSyncable {
    func syncScrollPosition(with otherView: ScrollSyncable) {
        if let targertIndexPath = otherView.currentIndexPath {
            scroll(to: targertIndexPath)
        }
    }
}

protocol ScrollSyncable {
    var currentIndexPath: IndexPath? { get }
    func scroll(to indexPath: IndexPath)
}

extension CharacterListTableView: ScrollSyncable {
    var currentIndexPath: IndexPath? {
        if let indexPaths = tableView.indexPathsForVisibleRows,
           let topRowIndexPath = indexPaths.min() {
            return topRowIndexPath
        }
        return nil
    }

    func scroll(to indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}

extension CharacterListCollectionView: ScrollSyncable {
    var currentIndexPath: IndexPath? {
        if let topItemIndexPath = collectionView.indexPathsForVisibleItems.min() {
            return topItemIndexPath
        }
        return nil
    }

    func scroll(to indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
    }
}
