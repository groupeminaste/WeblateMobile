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
                Picker("instances_units_query", selection: $viewModel.searchQuery) {
                    ForEach(SearchQuery.allCases) { query in
                        Text("instances_units_query_\(query.rawValue)".localized()).tag(query)
                    }
                }
                VStack {
                    HStack {
                        Text("instances_units_header")
                        Spacer()
                        if let total = viewModel.progressTotal, total != 0 {
                            Text("\(Int(Double(viewModel.units.filter({ $0.translated }).count) / Double(total)))%")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    if let total = viewModel.progressTotal, total != 0 {
                        ProgressView(
                            value: Double(viewModel.units.filter({ $0.translated }).count),
                            total: Double(total)
                        )
                    } else {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                .padding(.vertical, 8)
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
            } else if viewModel.nextPage != nil {
                Section {
                    ProgressView()
                        .progressViewStyle(.circular)
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
