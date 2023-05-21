//
//  FavouritesRepositoryMock.swift
//  PicturesTests
//
//  Created by Andrey on 21.05.2023.
//

@testable import Pictures

class FavouritesRepositoryMock: FavouritePicturesRepository {
    var pictures: [Pictures.PictureData] = []
    
    func save(picture: Pictures.PictureData) {
        pictures.append(picture)
    }
}
