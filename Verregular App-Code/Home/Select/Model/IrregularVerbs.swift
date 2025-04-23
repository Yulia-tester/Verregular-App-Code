//
//  IrregularVerbs.swift
//  Verregular App
//
//  Created by Юлия Дегтярева on 2025-04-12.
//

import Foundation

class IrregularVerbs {
    private(set) var verbs: [Verb] = []
    var selectedVerbs: [Verb] = []
    
    func configureVerbs() {
        verbs = [
            Verb(infinitive: "blow", pastSimple: "blew", participle: "blown"),
            Verb(infinitive: "draw", pastSimple: "drew", participle: "drawn"),
            Verb(infinitive: "eat", pastSimple: "ate", participle: "eaten"),
            Verb(infinitive: "fall", pastSimple: "fell", participle: "fallen")
        ]
    }
}
