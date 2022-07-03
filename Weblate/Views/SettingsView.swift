//
//  SettingsView.swift
//  Weblate
//
//  Created by Nathan Fallet on 03/07/2022.
//

import SwiftUI
import MyAppsiOS

struct SettingsView: View {
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        Form {
            Section(header: Text("settings_about")) {
                Button("settings_about_weblate") {
                    if let url = URL(string: "https://weblate.org/") {
                        openURL(url)
                    }
                }
            }
            Section(header: MyAppHeader()) {
                ForEach(MyApp.values) { app in
                    MyAppView(app: app)
                }
            }
        }
        .navigationTitle(Text("settings_title"))
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
    }
    
}
