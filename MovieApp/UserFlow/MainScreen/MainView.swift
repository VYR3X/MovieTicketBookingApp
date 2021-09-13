//
//  MainView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI

struct MainView: View {
    
    // DI
//    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var dashboardVM: DashboardViewModel
    
    var body: some View {
        
        NavigationView {
            
            if dashboardVM.presentFilterView {
                SearchView(dashboardVM: dashboardVM)
//                    .environment(\.managedObjectContext, viewContext)
                    .navigationBarHidden(true)
            } else {
                VStack {
                    // Navigation bar
                    HStack {
                        Image(systemName: "film.fill")
                            .font(.system(size: 26, weight: .bold, design: .default))
                        Text("Cenima")
                            .font(.system(size: 26, weight: .bold, design: .default))
                        Spacer()
                        // Open filter view
                        Button(action : {
                            dashboardVM.presentFilterView = true
                        }){
                            Image(systemName: "camera.filters")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .foregroundColor(Color.black.opacity(0.7))
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    // Main content in Scroll view
                    ScrollView(.vertical, showsIndicators: false) {
                        // Now Playing Movied
                        NowPlayingMoviedView(dashboardVM: dashboardVM)
                        // Popular Movie
                        PopularMovieView(dashboardVM: dashboardVM)
                        // Toprated Movie
                        TopratedMovieView(dashboardVM: dashboardVM)
                            .padding(.top, 8)
                        // Upcoming Movie
                        UpcomingMovieView(dashboardVM: dashboardVM)
                            .padding(.top, 8)
                    }
                    .padding(.top, 8)
                }
                .padding(.top, 16)
                .navigationBarHidden(true)
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
