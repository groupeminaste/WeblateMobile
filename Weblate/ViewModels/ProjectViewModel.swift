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
    @Published var nextPage: Int?
    
    // Methods
    
    init(instance: Instance, project: Project) {
        self.instance = instance
        self.project = project
    }
    
    func onAppear() {
        instance.api.getComponents(
            project: project.slug
        ) { data, status in
            if let data = data, status == .ok {
                // Save components
                self.components = data.results
                
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

        instance.api.getComponents(
            project: project.slug,
            page: nextPage
        ) { data, status in
            if let data = data, status == .ok {
                // Append
                self.components.append(contentsOf: data.results)
                
                // Check if there are more
                if data.next != nil {
                    self.nextPage = nextPage + 1
                }
            }
        }
    }
    
}
