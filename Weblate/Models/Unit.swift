//
//  Unit.swift
//  Weblate
//
//  Created by Nathan Fallet on 20/04/2022.
//

import Foundation

struct Unit: Codable, Identifiable {
    
    var id: Int64
    var source: [String]
    var target: [String]
    var context: String
    var note: String
    var explanation: String
    var state: Int
    var translated: Bool
    
}
