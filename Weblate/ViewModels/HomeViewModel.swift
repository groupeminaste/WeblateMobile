//
//  HomeViewModel.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    // Properties
    
    @Published var instances = [Instance]()
    @Published var showNewInstance = false
    
    // Methods
    
    func onAppear() {
        // Fetch instances from database
        self.instances = DatabaseService.shared.fetchInstances()
    }
    
}
