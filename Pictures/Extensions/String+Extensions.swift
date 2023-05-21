//
//  String+Extensions.swift
//  Pictures
//
//  Created by Andrey on 21.05.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
