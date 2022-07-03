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
        page: Int = 1,
        completionHandler: @escaping (APIResponse<Statistics>?, APIResponseStatus) -> Void
    ) {
        APIRequest("GET", path: "/api/components/\(project)/\(component)/statistics/", configuration: configuration)
            .with(name: "page", value: page)
            .execute(APIResponse<Statistics>.self, completionHandler: completionHandler)
    }
    
    func getComponentTranslations(
        project: String,
        component: String,
        page: Int = 1,
        completionHandler: @escaping (APIResponse<Translation>?, APIResponseStatus) -> Void
    ) {
        APIRequest("GET", path: "/api/components/\(project)/\(component)/translations/", configuration: configuration)
            .with(name: "page", value: page)
            .execute(APIResponse<Translation>.self, completionHandler: completionHandler)
    }
    
    func postComponentTranslations(
        project: String,
        component: String,
        language_code: String,
        completionHandler: @escaping (Translation?, APIResponseStatus) -> Void
    ) {
        APIRequest("POST", path: "/api/components/\(project)/\(component)/translations/", configuration: configuration)
            .with(body: [
                "language_code": language_code
            ])
            .execute(Translation.self, completionHandler: completionHandler)
    }
    
    func getTranslationUnits(
        project: String,
        component: String,
        language: String,
        q: String = "",
        page: Int = 1,
        completionHandler: @escaping (APIResponse<Unit>?, APIResponseStatus) -> Void
    ) {
        APIRequest("GET", path: "/api/translations/\(project)/\(component)/\(language)/units/", configuration: configuration)
            .with(name: "q", value: q)
            .with(name: "page", value: page)
            .execute(APIResponse<Unit>.self, completionHandler: completionHandler)
    }
    
    func patchUnit(
        unit: Int64,
        target: [String],
        state: Int,
        completionHandler: @escaping (Unit?, APIResponseStatus) -> Void
    ) {
        APIRequest("PATCH", path: "/api/units/\(unit)/", configuration: configuration)
            .with(body: ["target": target, "state": state])
            .execute(Unit.self, completionHandler: completionHandler)
    }
    
}
