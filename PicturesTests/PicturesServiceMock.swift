//
//  PicturesServiceMock.swift
//  PicturesTests
//
//  Created by Andrey on 21.05.2023.
//

@testable import Pictures

class PicturesServiceMock: PicturesService {
    
    var generator: ((String, @escaping PictureCompletion) -> Void)?
    
    func generatePicture(query: String, completion: @escaping PictureCompletion) {
        generator?(query, completion)
    }
}
