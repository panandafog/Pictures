//
//  PictureDataCoreData+CoreDataProperties.swift
//  Pictures
//
//  Created by Andrey on 21.05.2023.
//
//

import Foundation
import CoreData


extension PictureDataCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureDataCoreData> {
        return NSFetchRequest<PictureDataCoreData>(entityName: "PictureDataCoreData")
    }

    @NSManaged public var query: String
    @NSManaged public var createdAt: Date
    @NSManaged public var pictureData: Data

}
