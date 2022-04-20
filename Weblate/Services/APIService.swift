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
    
    func getProjectStatistics(
        project: String,
        completionHandler: @escaping (Statistics?, APIResponseStatus) -> Void
    ) {
        APIRequest("GET", path: "/api/projects/\(project)/statistics/", configuration: configuration)
            .execute(Statistics.self, completionHandler: completionHandler)
    }
    
    func getComponentStatistics(
        project: String,
        component: String,
        completionHandler: @escaping (APIResponse<Statistics>?, APIResponseStatus) -> Void
    ) {
        APIRequest("GET", path: "/api/components/\(project)/\(component)/statistics/", configuration: configuration)
            .execute(APIResponse<Statistics>.self, completionHandler: completionHandler)
    }
    
    func getComponentTranslations(
        project: String,
        component: String,
        completionHandler: @escaping (APIResponse<Translation>?, APIResponseStatus) -> Void
    ) {
        APIRequest("GET", path: "/api/components/\(project)/\(component)/translations/", configuration: configuration)
            .execute(APIResponse<Translation>.self, completionHandler: completionHandler)
    }
    
}
