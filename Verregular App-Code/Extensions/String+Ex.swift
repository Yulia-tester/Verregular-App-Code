//
//  String+Ex.swift
//  Verregular App-Code
//
//  Created by Юлия Дегтярева on 2025-04-17.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
