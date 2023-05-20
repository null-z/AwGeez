//
//  LocationDetailsView.swift
//  AwGeez
//
//  Created by Tony Dэ on 16.05.2023.
//  
//

import UIKit

class LocationDetailsView: TableViewController {
    
    private let presenter: LocationDetailsViewOutput
    
    init(presenter: LocationDetailsViewOutput) {
        self.presenter = presenter
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
}

// MARK: TableView
extension LocationDetailsView {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if case .residents(headerTitle: let title, residents: _) = presenter.viewModel.sections[section] {
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
            
            switch detailRow {
            case .type(title: let title, type: let body), .dimension(title: let title, dimension: let body):
                cell.titleLabel.text = title
                cell.detailLabel.text = body
                cell.selectionStyle = .none
            }
            return cell
            
        case .residents(headerTitle: _, residents: let residents):
            let resident = residents[indexPath.row]
            let cell = tableView.dequeueReusableCell(with: CharacterSmallCell.self)
            cell.setup(with: resident)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

// MARK: Prefetch
extension LocationDetailsView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = presenter.imageUrls(for: indexPaths)
        ImageLoader.prefetchImages(for: urls)
    }
}

// MARK: Make UI
extension LocationDetailsView {
    private func makeUI() {
        navigationItem.largeTitleDisplayMode = .always
        title = presenter.viewModel.name
        tableView.separatorStyle = .none
                        
        setupLayout()
    }
    
    private func setupLayout() {
    }
}

extension LocationDetailsView: LocationDetailsViewInput {
}
