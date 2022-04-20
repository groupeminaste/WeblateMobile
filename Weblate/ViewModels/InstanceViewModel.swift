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
    
    // Methods
    
    init(instance: Instance) {
        self.instance = instance
    }
    
    func onAppear() {
        let api = APIService(host: instance.host, token: instance.token)
        
        api.getProjects { data, status in
            if let data = data, status == .ok {
                self.projects = data.results
            }
        }
    }
    
}
