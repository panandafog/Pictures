//
//  Endpoints.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import Foundation

enum Endpoints {
    
    private static let baseComponents: URLComponents = {
        var baseComponents = URLComponents()
        baseComponents.scheme = "https"
        baseComponents.host = "dummyimage.com"
        return baseComponents
    }()
    
    static let imageComponents: URLComponents = {
        var components = baseComponents
        components.path = "/500x500"
        return components
    }()
}
