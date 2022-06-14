//
//  InstanceViewModel.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import Foundation

class InstanceViewModel: ObservableObject {
    
    // Properties
    
    @Published var instance: Instance
    @Published var projects = [Project]()
    @Published var nextPage: Int?
    
    // Methods
    
    init(instance: Instance) {
        self.instance = instance
    }
    
    func onAppear() {
        instance.api.getProjects { data, status in
            if let data = data, status == .ok {
                // Save projects
                self.projects = data.results
                
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

        instance.api.getProjects(page: nextPage) { data, status in
            if let data = data, status == .ok {
                // Append
                self.projects.append(contentsOf: data.results)
                
                // Check if there are more
                if data.next != nil {
                    self.nextPage = nextPage + 1
                }
            }
        }
    }
    
}
