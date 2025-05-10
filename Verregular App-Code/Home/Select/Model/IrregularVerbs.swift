//
//  IrregularVerbs.swift
//  Verregular App
//
//  Created by Юлия Дегтярева on 2025-04-12.
//

import Foundation

final class IrregularVerbs {
    
    // Singleton
    static var shared = IrregularVerbs()
    private init() {
        configureVerbs()
    }
    
    // MARK: - Properties
    var selectedVerbs: [Verb] = []
    private(set) var verbs: [Verb] = []
    
    // MARK: - Methods
    private func configureVerbs() {
        verbs = [
            Verb(infinitive: "blow", pastSimple: "blew", participle: "blown"),
            Verb(infinitive: "draw", pastSimple: "drew", participle: "drawn"),
            Verb(infinitive: "eat", pastSimple: "ate", participle: "eaten"),
            Verb(infinitive: "fall", pastSimple: "fell", participle: "fallen"),
            Verb(infinitive: "be", pastSimple: "was(were)", participle: "been"),
            Verb(infinitive: "begin", pastSimple: "began", participle: "begun"),
            Verb(infinitive: "drink", pastSimple: "drank", participle: "drunk"),
            Verb(infinitive: "feed", pastSimple: "fed", participle: "fed"),
            Verb(infinitive: "leave", pastSimple: "left", participle: "left"),
            Verb(infinitive: "meet", pastSimple: "met", participle: "met"),
            Verb(infinitive: "ride", pastSimple: "rode", participle: "ridden"),
            Verb(infinitive: "sell", pastSimple: "sold", participle: "sold"),
            Verb(infinitive: "teach", pastSimple: "taught", participle: "taught"),
            Verb(infinitive: "win", pastSimple: "won", participle: "won"),
            Verb(infinitive: "break", pastSimple: "broke", participle: "broken"),
            Verb(infinitive: "cut", pastSimple: "cut", participle: "cut")
        ]
        
        // Добавляем все глаголы в выбранные
            selectedVerbs = verbs
    }
}
