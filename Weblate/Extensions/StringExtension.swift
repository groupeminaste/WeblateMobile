//
//  StringExtension.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import Foundation

extension String {
    
    // Localization
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    func format(_ args: CVarArg...) -> String {
        return String(format: self, locale: .current, arguments: args)
    }
    
    func format(_ args: [String]) -> String {
        return String(format: self, locale: .current, arguments: args)
    }
    
    // Trimming
    
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
