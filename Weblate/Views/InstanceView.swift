//
//  InstanceView.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import SwiftUI

struct InstanceView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: InstanceViewModel
    
    var body: some View {
        Form {
            Section(header: Text("instances_projects")) {
                ForEach(viewModel.projects) { project in
                    NavigationLink(
                        destination: {
                            ProjectView(viewModel: ProjectViewModel(
                                instance: viewModel.instance,
                                project: project
                            ))
                        },
                        label: {
                            InstanceProjectView(
                                instance: viewModel.instance,
                                project: project
                            )
                        }
                    )
                }
            }
        }
        .navigationTitle(Text(viewModel.instance.name))
        .onAppear(perform: viewModel.onAppear)
    }
    
}

struct InstanceProjectView: View {
    
    let instance: Instance
    let project: Project
    
    @State var statistics: Statistics?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(project.name)
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
        
        api.getProjectStatistics(project: project.slug) { statistics, _ in
            self.statistics = statistics
        }
    }
    
}

struct InstanceView_Previews: PreviewProvider {
    
    static var previews: some View {
        InstanceView(viewModel: InstanceViewModel(
            instance: Instance(id: 0, name: "", host: "", token: "")
        ))
    }
    
}
