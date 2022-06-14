//
//  SearchQuery.swift
//  Weblate
//
//  Created by Nathan Fallet on 14/06/2022.
//

import Foundation

enum SearchQuery: String, CaseIterable, Identifiable {
    
    case untranslated = "untranslated"
    case unfinished = "unfinished"
    
    var id: String {
        rawValue
    }
    
    var query: String {
        switch self {
        case .untranslated:
            return "state:empty"
        case .unfinished:
            return "state:<translated"
        }
    }
    
}
