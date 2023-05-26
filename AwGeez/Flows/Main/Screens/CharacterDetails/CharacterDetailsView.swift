//
//  CharacterDetailsView.swift
//  AwGeez
//
//  Created by Tony Dэ on 10.05.2023.
//  
//

import UIKit
import Model

class CharacterDetailsView: TableViewController {
    
    private let presenter: CharacterDetailsViewOutput
    
    private var navigationBar: NavigationBar? {
        navigationController?.navigationBar as? NavigationBar
    }
    
    init(presenter: CharacterDetailsViewOutput) {
        self.presenter = presenter
        super.init()
    }
    
    private let tableHeaderView: StretchyTableHeaderView = StretchyTableHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBar()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        updateTableHeader()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }
}

// MARK: NavigationBar
extension CharacterDetailsView {
    
    private func updateNavigationBar() {
        let headerInset = view.frame.width - tableView.safeAreaInsets.top
        let scrollOffset = tableView.contentOffset.y
        if scrollOffset < headerInset {
            let diff = headerInset - scrollOffset
            let opactity = 1 - (1 / headerInset) * diff
            let color = UIColor.init(white: 1, alpha: opactity)
            navigationBar?.setBarColor(color)
            hideNavigationBar()
        } else {
            navigationBar?.resetColor()
            showNavigationBar()
        }
    }
        
    private func showNavigationBar() {
        guard let navigationBar else { return }
        navigationBar.titleTextAttributes = navigationBar.standardAppearance.titleTextAttributes
        navigationBar.backIndicatorImage = navigationBar.standardAppearance.backIndicatorImage
        navigationBar.backIndicatorTransitionMaskImage = navigationBar.standardAppearance.backIndicatorTransitionMaskImage
        navigationBar.resetColor()
    }
    
    private func hideNavigationBar() {
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationBar?.backIndicatorImage = R.image.backButton()
        navigationBar?.backIndicatorTransitionMaskImage = R.image.backButton()
    }
}

// MARK: TableHeader
extension CharacterDetailsView {
    private func updateTableHeader() {
        tableView.contentInset.top = -1 * tableView.safeAreaInsets.top
        tableHeaderView.frame.size.height = view.frame.size.width
    }
}

// MARK: ScrollView
extension CharacterDetailsView {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableHeaderView.scrollViewDidScroll(scrollView)
        updateNavigationBar()
    }
}

// MARK: TableView
extension CharacterDetailsView {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if case .episodes(headerTitle: let title, episodes: _) = presenter.viewModel.sections[section] {
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
            case .status(title: let title, status: let status):
                cell.titleLabel.text = title
                cell.detailLabel.attributedText = statusAttributedText(status: status)
                cell.selectionStyle = .none
                
            case .species(title: let title, species: let species):
                cell.titleLabel.text = title
                cell.detailLabel.text = species
                cell.selectionStyle = .none
                
            case .gender(title: let title, gender: let gender):
                cell.titleLabel.text = title
                cell.detailLabel.attributedText = genderAttributedText(gender: gender)
                cell.selectionStyle = .none
                
            case .origin(title: let title, location: let location), .location(title: let title, location: let location):
                cell.titleLabel.text = title
                cell.detailLabel.text = location
                cell.selectionStyle = .default
                cell.accessoryType = .disclosureIndicator
            }
            return cell
            
        case .episodes(headerTitle: _, episodes: let episodes):
            let episode = episodes[indexPath.row]
            let cell = tableView.dequeueReusableCell(with: EpisodeCell.self)
            cell.numbersLabel.text = episode.shortNumbers()
            cell.nameLabel.text = episode.name
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    private func statusAttributedText(status: Character.Status) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: status.coloredSymbol())
        let statusDescription = NSAttributedString(string: " " + status.rawValue.capitalized)
        result.append(statusDescription)
        return result
    }
    
    private func genderAttributedText(gender: Character.Gender) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: gender.coloredSign())
        let genderDescription = NSAttributedString(string: " " + gender.rawValue.capitalized)
        result.append(genderDescription)
        return result
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

// MARK: Make UI
extension CharacterDetailsView {
    private func makeUI() {
        navigationItem.largeTitleDisplayMode = .never
        title = presenter.viewModel.name
        tableView.separatorStyle = .none
        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.setImageUrl(presenter.viewModel.imageUrl)
        tableHeaderView.setTitle(presenter.viewModel.name)
        
        setupLayout()
    }
    
    private func setupLayout() {
    }
}

// MARK: ViewInput
extension CharacterDetailsView: CharacterDetailsViewInput {
}
