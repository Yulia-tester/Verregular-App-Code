//
//  Verb.swift
//  Verregular App
//
//  Created by Юлия Дегтярева on 2025-04-12.
//

import Foundation

struct Verb {
    let infinitive: String
    let pastSimple: String
    let participle: String
    var translation: String {
        NSLocalizedString(self.infinitive, comment: "")
    }
}
