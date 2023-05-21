//
//  FavouritesViewController.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @objc let viewModel = FavouritesViewModel()
    
    private let tableView = UITableView()
    
    private var observations: Set<NSKeyValueObservation> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupSubviews()
        setupConstraints()
        setupStyling()
        setupObservations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateFavourites()
        tabBarController?.title = "Favourites.Title".localized
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavouritePictureCell.self, forCellReuseIdentifier: FavouritePictureCell.reusableID)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: tableView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 0
        ).isActive = true
        
        NSLayoutConstraint(
            item: tableView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        ).isActive = true
        
        NSLayoutConstraint(
            item: tableView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        ).isActive = true
        
        NSLayoutConstraint(
            item: tableView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        ).isActive = true
    }
    
    private func setupStyling() {
        view.backgroundColor = .white
    }
    
    private func setupObservations() {
        observations.insert(observe(\.viewModel.favouritePictures, options: [.new]) { [weak self] object, change in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
}

extension FavouritesViewController: UITableViewDelegate {
    
}

extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var pictureData: PictureData?
        if indexPath.row < viewModel.favouritePictures.count {
            pictureData = viewModel.favouritePictures[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritePictureCell.reusableID, for: indexPath)
        if let cell = cell as? FavouritePictureCell {
            cell.pictureData = pictureData
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favouritePictures.count
    }
}
