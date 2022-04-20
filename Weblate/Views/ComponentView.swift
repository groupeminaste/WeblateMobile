//
//  ComponentView.swift
//  Weblate
//
//  Created by Nathan Fallet on 20/04/2022.
//

import SwiftUI

struct ComponentView: View {
    
    @StateObject var viewModel: ComponentViewModel
    
    var body: some View {
        Form {
            Section(header: Text("instances_translations")) {
                ForEach(viewModel.translations) { translation in
                    NavigationLink(
                        destination: {
                            TranslationView(viewModel: TranslationViewModel(
                                instance: viewModel.instance,
                                project: viewModel.project,
                                component: viewModel.component,
                                translation: translation
                            ))
                        },
                        label: {
                            ComponentTranslationView(
                                instance: viewModel.instance,
                                project: viewModel.project,
                                component: viewModel.component,
                                translation: translation
                            )
                        }
                    )
                }
            }
        }
        .navigationTitle(Text(viewModel.component.name))
        .onAppear(perform: viewModel.onAppear)
    }
    
}

struct ComponentTranslationView: View {
    
    let instance: Instance
    let project: Project
    let component: Component
    let translation: Translation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(translation.language.name) (\(translation.language.code))")
                Spacer()
                Text("\(Int(translation.translated_percent))%")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            ProgressView(
                value: translation.translated_percent,
                total: 100
            )
        }
        .padding(.vertical, 8)
    }
    
}

struct ComponentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ComponentView(viewModel: ComponentViewModel(
            instance: Instance(id: 0, name: "", host: "", token: ""),
            project: Project(id: 0, name: "", slug: ""),
            component: Component(id: 0, name: "", slug: "")
        ))
    }
    
}
