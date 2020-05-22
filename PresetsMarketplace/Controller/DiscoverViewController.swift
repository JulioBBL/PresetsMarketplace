//
//  DiscoverViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 18/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {

    var collectionView: DynamicCollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Descobrir"

        setupSearchController()
        setupCollectionView()
    }

    override func viewDidLayoutSubviews() {
        setupCollectionViewConstraints()
    }

    func setupCollectionView() {
        collectionView = DynamicCollectionView(collectionType: .user, with: Mock.shared.presets)
        guard let collectionView = collectionView else { return }
        collectionView.reloadData()
        self.view.addSubview(collectionView)
    }

    func setupCollectionViewConstraints() {
        guard let collectionView = collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])

        collectionView.backgroundColor = .clear
    }

    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Busque por artistas e presets"
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
}

extension DiscoverViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let collectionView = collectionView else { return }

        let query = searchController.searchBar.text ?? ""
        collectionView.searchDelegate?.search(usingQuery: query) {
            presets in
            collectionView.collectionViewDelegate?.updatePresets(to: presets)
            collectionView.reloadData()
        }
    }
}
