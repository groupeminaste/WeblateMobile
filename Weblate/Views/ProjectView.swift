//
//  ProjectView.swift
//  Weblate
//
//  Created by Nathan Fallet on 20/04/2022.
//

import SwiftUI

struct ProjectView: View {
    
    @StateObject var viewModel: ProjectViewModel
    
    var body: some View {
        Form {
            Section(header: Text("instances_components")) {
                ForEach(viewModel.components) { component in
                    NavigationLink(
                        destination: {
                            ComponentView(viewModel: ComponentViewModel(
                                instance: viewModel.instance,
                                project: viewModel.project,
                                component: component
                            ))
                        },
                        label: {
                            ProjectComponentView(
                                instance: viewModel.instance,
                                project: viewModel.project,
                                component: component
                            )
                        }
                    )
                }
                if viewModel.nextPage != nil {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .onAppear(perform: viewModel.loadMore)
                }
            }
        }
        .navigationTitle(Text(viewModel.project.name))
        .onAppear(perform: viewModel.onAppear)
    }
    
}

struct ProjectComponentView: View {
    
    let instance: Instance
    let project: Project
    let component: Component
    
    @State var statistics: Statistics?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(project.name)
                    .foregroundColor(.secondary)
                Text("/")
                    .foregroundColor(.secondary)
                Text(component.name)
                Spacer()
                if let statistics = statistics {
                    Text("\(Int(statistics.translated_percent))%")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            ProgressView(
                value: statistics?.translated_percent ?? 0,
                total: 100
            )
        }
        .padding(.vertical, 8)
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        let api = APIService(host: instance.host, token: instance.token)
        
        api.getComponentStatistics(project: project.slug, component: component.slug) { data, status in
            if let data = data, status == .ok {
                if data.results.isEmpty {
                    self.statistics = Statistics(
                        translated_percent: 0
                    )
                } else {
                    self.statistics = Statistics(
                        translated_percent: data
                            .results
                            .map(\.translated_percent)
                            .reduce(0, +)
                        / Double(data.results.count)
                    )
                }
            }
        }
    }
    
}

struct ProjectView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProjectView(viewModel: ProjectViewModel(
            instance: Instance(id: 0, name: "", host: "", token: ""),
            project: Project(id: 0, name: "", slug: "")
        ))
    }
    
}
