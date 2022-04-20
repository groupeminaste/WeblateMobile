//
//  Project.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import Foundation

struct Project: Codable, Identifiable {
    
    var id: Int64
    var name: String
    var slug: String
    
}
