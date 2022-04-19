//
//  Component.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import Foundation

struct Component: Codable {
    
    var id: Int
    var name: String
    var slug: String
    var project: Project?
    
}
