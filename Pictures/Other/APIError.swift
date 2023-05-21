//
//  APIError.swift
//  Pictures
//
//  Created by Andrey on 21.05.2023.
//

import Foundation

enum APIError: Error {
    case parsingResponse
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parsingResponse:
            return NSLocalizedString(
                "Error.ParsingResponse.Text".localized,
                comment: "Error.ParsingResponse.Comment".localized
            )
        }
    }
}
