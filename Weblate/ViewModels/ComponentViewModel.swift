//
//  ComponentViewModel.swift
//  Weblate
//
//  Created by Nathan Fallet on 20/04/2022.
//

import Foundation

class ComponentViewModel: ObservableObject {
    
    // Properties
    
    @Published var instance: Instance
    @Published var project: Project
    @Published var component: Component
    @Published var translations = [Translation]()
    
    // Methods
    
    init(instance: Instance, project: Project, component: Component) {
        self.instance = instance
        self.project = project
        self.component = component
    }
    
    func onAppear() {
        let api = APIService(host: instance.host, token: instance.token)
        
        api.getComponentTranslations(project: project.slug, component: component.slug) { data, status in
            if let data = data, status == .ok {
                self.translations = data.results
            }
        }
    }
    
}
