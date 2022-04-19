//
//  APIService.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import APIRequest

class APIService {
    
    // Properties and methods
    
    let configuration: APIConfiguration
    
    init(host: String, token: String) {
        self.configuration = APIConfiguration(host: host, headers: {
            ["Authorization": "Token \(token)"]
        })
    }
    
    func getProjects(
        page: Int = 1,
        completionHandler: @escaping (APIResponse<Project>?, APIResponseStatus) -> Void
    ) {
        APIRequest("GET", path: "/api/projects/", configuration: configuration)
            .with(name: "page", value: page)
            .execute(APIResponse<Project>.self, completionHandler: completionHandler)
    }
    
    func getComponents(
        page: Int = 1,
        completionHandler: @escaping (APIResponse<Component>?, APIResponseStatus) -> Void
    ) {
        APIRequest("GET", path: "/api/components/", configuration: configuration)
            .with(name: "page", value: page)
            .execute(APIResponse<Component>.self, completionHandler: completionHandler)
    }
    
    func getComponents(
        project: String,
        page: Int = 1,
        completionHandler: @escaping (APIResponse<Component>?, APIResponseStatus) -> Void
    ) {
        APIRequest("GET", path: "/api/projects/\(project)/components/", configuration: configuration)
            .with(name: "page", value: page)
            .execute(APIResponse<Component>.self, completionHandler: completionHandler)
    }
    
}
