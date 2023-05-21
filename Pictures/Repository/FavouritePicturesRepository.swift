//
//  FavouritePicturesRepository.swift
//  Pictures
//
//  Created by Andrey on 21.05.2023.
//

import CoreData

protocol FavouritePicturesRepository {
    var pictures: [PictureData] { get }
    func save(picture: PictureData)
}

class FavouritePicturesRepositoryImpl: FavouritePicturesRepository {
    
    private static let picturesContainerName = "Pictures"
    
    static let shared = FavouritePicturesRepositoryImpl()
    
    var pictures: [PictureData] {
        coreDataPictures.compactMap {
            PictureData(coreDataPicture: $0)
        }
    }
    
    private static let picturesCountLimit = 5
    
    private let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    private var coreDataPictures: [PictureDataCoreData] {
        fetchPictures()
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: Self.picturesContainerName)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("CoreData error \(error.localizedDescription)")
            }
        })
        
        context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save(picture: PictureData) {
        guard let pngData = picture.picture.pngData() else { return }
        
        let coreDataModel = PictureDataCoreData(context: context)
        coreDataModel.query = picture.query
        coreDataModel.createdAt = picture.createdAt
        coreDataModel.pictureData = pngData
        saveContext()
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                fatalError("CoreData error \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchPictures() -> [PictureDataCoreData] {
        let fetchRequest: NSFetchRequest<PictureDataCoreData> = PictureDataCoreData.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            removeOldIfNeeded(objects: objects)
            return objects
        } catch {
            return []
        }
    }
    
    private func removeOldIfNeeded(objects: [PictureDataCoreData]) {
        let objectsCount = objects.count
        guard objectsCount > Self.picturesCountLimit else { return }
        
        if objectsCount == Self.picturesCountLimit + 1 {
            var objectToDelete: PictureDataCoreData?
            objects.forEach {
                if objectToDelete == nil || $0.createdAt < objectToDelete!.createdAt {
                    objectToDelete = $0
                }
            }
            if let objectToDelete = objectToDelete {
                context.delete(objectToDelete)
            }
        } else {
            let objectsToDeleteRange = Self.picturesCountLimit...
            let objectsToDelete = objects.sorted(by: { $0.createdAt > $1.createdAt })[objectsToDeleteRange]
            
            objectsToDelete.forEach { context.delete($0) }
        }
        
        saveContext()
    }
}
