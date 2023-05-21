//
//  PicturesService.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit

protocol PicturesService {
    typealias PictureCompletion = (Result<PictureData, Error>) -> Void
    
    func generatePicture(query: String, completion: @escaping PictureCompletion)
}

class PicturesServiceImpl: PicturesService {
    
    private static let session: URLSession = .shared
    private static let lastPicturesLimit = 50
    
    private var lastPictures: [String: PictureData] = [:]
    
    func generatePicture(query: String, completion: @escaping PictureCompletion) {
        if let picture = lastPictures[query] {
            completion(.success(picture))
            return
        }
        
        var components = Endpoints.imageComponents
        components.queryItems = [
            URLQueryItem(name: "text", value: query)
        ]
        guard let url = components.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        Self.session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                if let picture = UIImage(data: data) {
                    let pictureData = PictureData(query: query, picture: picture)
                    self?.save(picture: pictureData)
                    completion(.success(pictureData))
                } else {
                    completion(.failure(APIError.parsingResponse))
                }
            } else {
                completion(.failure(APIError.parsingResponse))
            }
        }.resume()
    }
    
    private func save(picture: PictureData) {
        lastPictures[picture.query] = picture
        
        removeOldFromLastPictures()
    }
    
    private func removeOldFromLastPictures() {
        guard lastPictures.count <= Self.lastPicturesLimit else { return }
        
        var minDate: Date?
        var query: String?
        lastPictures.values.forEach {
            if let minDate_ = minDate {
                if $0.createdAt < minDate_ {
                    minDate = $0.createdAt
                    query = $0.query
                }
            } else {
                minDate = $0.createdAt
                query = $0.query
            }
        }
        
        guard let query = query else { return }
        lastPictures[query] = nil
    }
}
