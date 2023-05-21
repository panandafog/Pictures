//
//  FavouritesViewModel.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit

class FavouritesViewModel: NSObject {
    
    @objc dynamic private (set) var favouritePictures: [PictureData] = []
    
    private let repository: FavouritePicturesRepository
    
    func updateFavourites() {
        favouritePictures = repository.pictures.sorted { $0.createdAt > $1.createdAt }
    }
    
    init(repository: FavouritePicturesRepository? = nil) {
        self.repository = repository ?? FavouritePicturesRepositoryImpl.shared
    }
}
