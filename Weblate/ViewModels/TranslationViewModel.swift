//
//  TranslationViewModel.swift
//  Weblate
//
//  Created by Nathan Fallet on 20/04/2022.
//

import Foundation

class TranslationViewModel: ObservableObject {
    
    // Properties
    
    @Published var instance: Instance
    @Published var project: Project
    @Published var component: Component
    @Published var translation: Translation
    @Published var units = [Unit]()
    
    @Published var currentUnit: Int64 = 0
    @Published var currentIndex = 0
    @Published var currentContext = ""
    @Published var currentExplanation = ""
    @Published var currentSource = ""
    @Published var currentTarget = ""
    
    // Methods
    
    init(instance: Instance, project: Project, component: Component, translation: Translation) {
        self.instance = instance
        self.project = project
        self.component = component
        self.translation = translation
    }
    
    func onAppear() {
        let api = APIService(host: instance.host, token: instance.token)
        
        api.getTranslationUnits(
            project: project.slug,
            component: component.slug,
            language: translation.language.code
        ) { data, status in
            if let data = data, status == .ok {
                self.units = data.results
            }
            
            self.loadNextUnit()
        }
    }
    
    func loadNextUnit() {
        if let next = units.first(where: { !$0.translated && $0.id >= currentUnit }),
           let index = next.target.firstIndex(where: { $0.isEmpty }) {
            currentUnit = next.id
            currentContext = next.context
            currentExplanation = next.explanation
            currentIndex = index
            currentSource = next.source[index]
            currentTarget = next.target[index]
        } else {
            currentUnit = 0
        }
    }
    
    func saveCurrent() {
        guard let currentUnitIndex = units.firstIndex(where: { $0.id == currentUnit })
        else { return }
        
        // Save what we just translated
        units[currentUnitIndex].target[currentIndex] = currentTarget
        units[currentUnitIndex].translated = !units[currentUnitIndex].target.contains(where: { $0.isEmpty })
        
        let api = APIService(host: instance.host, token: instance.token)
        api.patchUnit(
            unit: units[currentUnitIndex].id,
            target: units[currentUnitIndex].target,
            state: max(units[currentUnitIndex].translated ? 20 : 0, units[currentUnitIndex].state)
        ) { data, status in
            // Go to the next one
            self.loadNextUnit()
        }
    }
    
}
