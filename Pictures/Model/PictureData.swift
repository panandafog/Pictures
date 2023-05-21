//
//  PictureData.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit

class PictureData: NSObject {
    @objc dynamic var query: String
    @objc dynamic var picture: UIImage
    @objc dynamic var createdAt: Date
    
    init(query: String, picture: UIImage, createdAt: Date? = nil) {
        self.query = query
        self.picture = picture
        self.createdAt = createdAt ?? Date()
    }
    
    convenience init?(coreDataPicture: PictureDataCoreData) {
        guard let uiImage = UIImage(data: coreDataPicture.pictureData) else { return nil }
        
        self.init(
            query: coreDataPicture.query,
            picture: uiImage,
            createdAt: coreDataPicture.createdAt
        )
    }
}
