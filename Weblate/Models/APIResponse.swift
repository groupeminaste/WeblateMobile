//
//  APIResponse.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    
    var count: Int
    var next: String?
    var previous: String?
    var results: [T]
    
}
