//
//  TranslationView.swift
//  Weblate
//
//  Created by Nathan Fallet on 20/04/2022.
//

import SwiftUI

struct TranslationView: View {
    
    @StateObject var viewModel: TranslationViewModel
    
    var body: some View {
        Form {
            Section(header: Text("instances_units_header")) {
                // Make some header for the translation view (to track state)
                Text("Add some header here")
            }
            
            if viewModel.currentUnit != 0 {
                Section(
                    header: Text(viewModel.currentContext),
                    footer: Text(viewModel.currentExplanation)
                ) {
                    Text(viewModel.currentSource)
                    TextField("instances_units_field", text: $viewModel.currentTarget)
                    Button("instances_units_save", action: viewModel.saveCurrent)
                }
            }
        }
        .navigationTitle(Text(viewModel.translation.language.name))
        .onAppear(perform: viewModel.onAppear)
    }
    
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(viewModel: TranslationViewModel(
            instance: Instance(id: 0, name: "", host: "", token: ""),
            project: Project(id: 0, name: "", slug: ""),
            component: Component(id: 0, name: "", slug: ""),
            translation: Translation(id: 9, language: Language(code: "", name: ""), is_source: true, translated_percent: 0)
        ))
    }
}
