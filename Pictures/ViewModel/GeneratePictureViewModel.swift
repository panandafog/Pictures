//
//  GeneratePictureViewModel.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit

protocol GeneratePictureViewModelDelegate: ErrorHandling {
//    func handleError(_: Error)
}

class GeneratePictureViewModel: NSObject {
    
    private static let minQueryLength = 1
    
    @objc dynamic private (set) var picture: PictureData?
    @objc dynamic private (set) var submitEnabled = false
    @objc dynamic private (set) var addToFavouritesEnabled = false
    @objc dynamic private (set) var loadingInProgress = false
    
    private let repository: FavouritePicturesRepository
    private let service: PicturesService
    
    var delegate: GeneratePictureViewModelDelegate?
    
    var query = "" {
        didSet {
            updateSubmit()
        }
    }
    
    var queryIsValid: Bool {
        query.count >= Self.minQueryLength
    }
    
    init(repository: FavouritePicturesRepository? = nil, service: PicturesService? = nil) {
        self.repository = repository ?? FavouritePicturesRepositoryImpl.shared
        self.service = service ?? PicturesServiceImpl()
    }
    
    func submit() {
        loadingInProgress = true
        submitEnabled = false
        addToFavouritesEnabled = false
        
        let query = self.query
        
        service.generatePicture(query: query) { [weak self] result in
            switch result {
            case .success(let picture):
                self?.picture = picture
            case .failure(let error):
                self?.delegate?.handle(error: error, title: "Error.GeneratingPicture.Title".localized)
            }
            self?.loadingInProgress = false
            self?.updateSubmit()
            self?.updateAddToFavourites()
        }
    }
    
    func addToFavourites() {
        guard let picture = picture else { return }
        repository.save(picture: picture)
    }
    
    private func updateSubmit() {
        submitEnabled = queryIsValid && !loadingInProgress
    }
    
    private func updateAddToFavourites() {
        addToFavouritesEnabled = picture != nil
    }
}
