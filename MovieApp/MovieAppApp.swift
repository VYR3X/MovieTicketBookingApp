//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by v.zhokhov on 09.09.2021.
//

import SwiftUI

@main
struct MovieAppApp: App {
    
//    let persistenceContainer = PersistenceContainer.shared
    @StateObject var dashboardVM = DashboardViewModel(service: NetworkService())
    
    var body: some Scene {
        WindowGroup {
            MainView(dashboardVM: dashboardVM)
//                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
//            ContentView()
        }
    }
}
