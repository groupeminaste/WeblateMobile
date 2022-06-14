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
    @Published var nextPage: Int?
    
    // Methods
    
    init(instance: Instance, project: Project, component: Component) {
        self.instance = instance
        self.project = project
        self.component = component
    }
    
    func onAppear() {
        instance.api.getComponentTranslations(
            project: project.slug,
            component: component.slug
        ) { data, status in
            if let data = data, status == .ok {
                // Save translations
                self.translations = data.results
                
                // Check if there are more
                if data.next != nil {
                    self.nextPage = 2
                }
            }
        }
    }
    
    func loadMore() {
        guard let nextPage = nextPage else {
            return
        }

        instance.api.getComponentTranslations(
            project: project.slug,
            component: component.slug,
            page: nextPage
        ) { data, status in
            if let data = data, status == .ok {
                // Append
                self.translations.append(contentsOf: data.results)
                
                // Check if there are more
                if data.next != nil {
                    self.nextPage = nextPage + 1
                }
            }
        }
    }
    
}
