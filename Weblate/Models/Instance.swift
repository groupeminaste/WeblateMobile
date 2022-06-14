//
//  Instance.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import Foundation

struct Instance: Codable, Identifiable {
    
    var id: Int64
    var name: String
    var host: String
    var token: String
    
    var api: APIService {
        APIService(host: host, token: token)
    }
    
}
