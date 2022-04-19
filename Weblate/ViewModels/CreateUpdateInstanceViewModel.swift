//
//  CreateUpdateInstanceViewModel.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import Foundation

class CreateUpdateInstanceViewModel: ObservableObject {
    
    // Properties
    
    let onDone: () -> Void
    
    @Published var showDeleteDialog = false
    @Published var instance: Instance
    @Published var name: String
    @Published var host: String
    @Published var token: String
    
    // Initializer
    
    init(instance: Instance, onDone: @escaping () -> Void) {
        self.instance = instance
        self.onDone = onDone
        self.name = instance.name
        self.host = instance.host
        self.token = instance.token
    }
    
    func save() {
        // Update values
        instance.name = name
        instance.host = host
        instance.token = token
        
        // Check if instance already exists
        if instance.id == -1 {
            // Insert
            instance.id = DatabaseService.shared.createInstance(instance: instance)
        } else {
            // Update
            //DatabaseService.shared.updateInstance(instance: instance)
        }
        
        // Done
        onDone()
    }
    
    func preDelete() {
        showDeleteDialog = true
    }
    
    func delete() {
        // Delete from database
        //DatabaseService.shared.deleteInstance(instance: instance)
        onDone()
    }
    
}
