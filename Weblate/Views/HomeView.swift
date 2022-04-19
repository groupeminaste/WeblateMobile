//
//  HomeView.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import SwiftUI
import MyAppsiOS

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("instances_title")) {
                    if viewModel.instances.isEmpty {
                        Text("instances_empty")
                    } else {
                        ForEach(viewModel.instances) { instance in
                            HStack(spacing: 12) {
                                Image("Weblate")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .cornerRadius(8)
                                    .padding(.vertical, 8)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(instance.name)
                                    Text(instance.host)
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                Section {
                    Button("instances_new") {
                        viewModel.showNewInstance.toggle()
                    }
                }
                Section(header: MyAppHeader()) {
                    ForEach(MyApp.values) { app in
                        MyAppView(app: app)
                    }
                }
            }
            .navigationTitle(Text("Weblate Mobile"))
            .sheet(isPresented: $viewModel.showNewInstance) {
                CreateUpdateInstanceView(viewModel: CreateUpdateInstanceViewModel(
                    instance: Instance(id: -1, name: "", host: "", token: ""),
                    onDone: viewModel.onAppear
                ))
            }
            .onAppear(perform: viewModel.onAppear)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
    
}
