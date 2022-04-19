//
//  CreateUpdateInstanceView.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import SwiftUI

struct CreateUpdateInstanceView: View {
    
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: CreateUpdateInstanceViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("instances_name")) {
                    TextField("Weblate Hosted", text: $viewModel.name)
                }
                Section(header: Text("instances_host")) {
                    TextField("hosted.weblate.org", text: $viewModel.host)
                        .keyboardType(.URL)
                    if viewModel.host.isEmpty {
                        Button("instances_use".localized().format("hosted.weblate.org")) {
                            viewModel.host = "hosted.weblate.org"
                        }
                        Button("instances_use".localized().format("weblate.groupe-minaste.org")) {
                            viewModel.host = "weblate.groupe-minaste.org"
                        }
                    }
                }
                Section(header: Text("instances_token"), footer: Text("instances_token_footer")) {
                    TextField("wlu_...", text: $viewModel.token)
                }
                Section {
                    Button("instances_save") {
                        viewModel.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(viewModel.name.isEmpty || viewModel.host.isEmpty || viewModel.token.isEmpty)
                }
            }
            .toolbar {
                if viewModel.instance.id != -1 {
                    Button(action: viewModel.preDelete) {
                        Image(systemName: "trash")
                    }
                }
            }
            .alert(isPresented: $viewModel.showDeleteDialog) {
                Alert(
                    title: Text("instances_delete_dialog"),
                    primaryButton: .default(Text("delete")) {
                        viewModel.delete()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel(Text("cancel"))
                )
            }
            .navigationTitle(Text(viewModel.instance.id == -1 ? "instances_new" : "instances_update"))
        }
    }
    
}

struct CreateUpdateInstanceView_Previews: PreviewProvider {
    
    static var previews: some View {
        CreateUpdateInstanceView(viewModel: CreateUpdateInstanceViewModel(
            instance: Instance(id: -1, name: "", host: "", token: ""),
            onDone: {}
        ))
    }
    
}
