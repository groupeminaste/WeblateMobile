//
//  ProjectViewModel.swift
//  Weblate
//
//  Created by Nathan Fallet on 20/04/2022.
//

import Foundation

class ProjectViewModel: ObservableObject {
    
    // Properties
    
    @Published var instance: Instance
    @Published var project: Project
    @Published var components = [Component]()
    
    // Methods
    
    init(instance: Instance, project: Project) {
        self.instance = instance
        self.project = project
    }
    
    func onAppear() {
        let api = APIService(host: instance.host, token: instance.token)
        
        api.getComponents(
            project: project.slug
        ) { data, status in
            if let data = data, status == .ok {
                self.components = data.results
            }
        }
    }
    
}
