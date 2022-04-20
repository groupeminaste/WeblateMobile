//
//  Translation.swift
//  Weblate
//
//  Created by Nathan Fallet on 20/04/2022.
//

import Foundation

struct Translation: Codable, Identifiable {
    
    var id: Int64
    var language: Language
    var is_source: Bool
    var translated_percent: Double
    
}
