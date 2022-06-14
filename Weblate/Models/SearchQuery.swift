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
    case translated = "translated"
    case needsEditing = "needsEditing"
    case suggestion = "suggestion"
    case variant = "variant"
    case label = "label"
    case context = "context"
    case unfinishedWithoutSuggestion = "unfinishedWithoutSuggestion"
    case comment = "comment"
    case check = "check"
    case approved = "approved"
    case waitingForReview = "waitingForReview"
    
    var id: String {
        rawValue
    }
    
    var query: String {
        switch self {
        case .untranslated:
            return "state:empty"
        case .unfinished:
            return "state:<translated"
        case .translated:
            return "state:>=translated"
        case .needsEditing:
            return "state:needs-editing"
        case .suggestion:
            return "has:suggestion"
        case .variant:
            return "has:variant"
        case .label:
            return "has:label"
        case .context:
            return "has:context"
        case .unfinishedWithoutSuggestion:
            return "state:<translated AND NOT has:suggestion"
        case .comment:
            return "has:comment"
        case .check:
            return "has:check"
        case .approved:
            return "state:approved"
        case .waitingForReview:
            return "state:translated"
        }
    }
    
}
