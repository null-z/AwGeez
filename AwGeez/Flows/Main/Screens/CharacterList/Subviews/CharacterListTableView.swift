//
//  CharacterListTableView.swift
//  AwGeez
//
//  Created by Tony Dэ on 26.04.2023.
//  
//

import UIKit

class CharacterListTableView: TableViewController {
    
    private let presenter: CharacterListViewOutput
    
    init(presenter: CharacterListViewOutput) {
        self.presenter = presenter
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        makeUI()
    }
}

extension CharacterListTableView {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CharacterCell.height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CharacterCell.self)
        let viewModel = presenter.viewModel(for: indexPath.row)
        cell.setup(with: viewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(for: indexPath.row)
    }
}

// MARK: Prefetch
extension CharacterListTableView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let indexes = indexPaths.map { $0.row }
        let urls = presenter.imageUrls(for: indexes)
        ImageLoader.prefetchImages(for: urls)
    }
}

// MARK: Make UI
extension CharacterListTableView {
    private func makeUI() {
        navigationItem.largeTitleDisplayMode = .always
        title = presenter.title()
        tableView.backgroundColor = nil
        tableView.separatorStyle = .none
        
        setupLayout()
    }
    
    private func setupLayout() {
    }
}

// MARK: ViewInput
extension CharacterListTableView: CharacterListViewInput {
}
