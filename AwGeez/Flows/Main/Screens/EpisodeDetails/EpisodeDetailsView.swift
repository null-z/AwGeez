//
//  EpisodeDetailsView.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.05.2023.
//  
//

import UIKit

class EpisodeDetailsView: TableViewController {
    
    private let presenter: EpisodeDetailsViewOutput
    
    init(presenter: EpisodeDetailsViewOutput) {
        self.presenter = presenter
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        makeUI()
    }
}

// MARK: TableView
extension EpisodeDetailsView {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if case .characters(headerTitle: let title, characters: _) = presenter.viewModel.sections[section] {
            return title
        }
        return nil
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.viewModel.sections[section].rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = presenter.viewModel.sections[indexPath.section]

        switch section {
        case .details(let detailsRows):
            let detailRow = detailsRows[indexPath.row]
            let cell = tableView.dequeueReusableCell(with: TitledTextCell.self)
            cell.selectionStyle = .none

            switch detailRow {
            case .season(text: let text), .episode(text: let text):
                cell.titleLabel.text = nil
                cell.detailLabel.text = text
            
            case .airDate(title: let title, airDate: let body):
                cell.titleLabel.text = title
                cell.detailLabel.text = body
            }
            return cell

        case .characters(headerTitle: _, characters: let characters):
            let character = characters[indexPath.row]
            let cell = tableView.dequeueReusableCell(with: CharacterSmallCell.self)
            cell.setup(with: character)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

// MARK: Prefetch
extension EpisodeDetailsView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = presenter.imageUrls(for: indexPaths)
        ImageLoader.prefetchImages(for: urls)
    }
}

// MARK: Make UI
extension EpisodeDetailsView {
    private func makeUI() {
        navigationItem.largeTitleDisplayMode = .always
        title = presenter.viewModel.title
        tableView.separatorStyle = .none
        
        setupLayout()
    }
    
    private func setupLayout() {
    }
}

extension EpisodeDetailsView: EpisodeDetailsViewInput {
}
