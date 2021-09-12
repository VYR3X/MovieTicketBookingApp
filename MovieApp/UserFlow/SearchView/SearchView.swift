//
//  SearchView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI
//import Kingfisher

// Экран поиска кинофильма
struct SearchView : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var dashboardVM : DashboardViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: NowPlaying.entity(), sortDescriptors:[NSSortDescriptor(keyPath: \NowPlaying.timeStamp, ascending: true)])
    // NowPlaying - модель в core data
    var nowPlayingMovies: FetchedResults<NowPlaying>
    @FetchRequest(entity: Popular.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Popular.timeStamp, ascending: true)])
    // NowPlaying - модель в core data
    var popularMovies: FetchedResults<Popular>
    @FetchRequest(entity: Upcoming.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Upcoming.timeStamp, ascending: true)])
    // NowPlaying - модель в core data
    var upcomingMovie: FetchedResults<Upcoming>
    @FetchRequest(entity: TopRated.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TopRated.timeStamp, ascending: true)])
    // NowPlaying - модель в core data
    var topratedMovie: FetchedResults<TopRated>
    
    var body: some View {
        
        VStack{
            navigationBarWithSearchBar
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVStack(alignment : .leading) {
                    
                    ForEach(nowPlayingMovies, id : \.self) { item in
                        ForEach(item.nowPlayingMovie!.filter({ (value) -> Bool in
                            
                            dashboardVM.filterDataFormLocal(value: value)
                            
                        }), id: \.uniqueID) { value in
                            SearchCardView(data: value, dashboardVM: dashboardVM)
                        }
                    }
                    
                    ForEach(popularMovies, id : \.self) { item in
                        ForEach(item.popularMovie!.filter({ (value) -> Bool in
                            
                            dashboardVM.filterDataFormLocal(value: value)
                            
                        }), id: \.uniqueID) { value in
                            SearchCardView(data: value, dashboardVM: dashboardVM)
                        }
                    }
                    
                    ForEach(topratedMovie, id : \.self) { item in
                        ForEach(item.topRatedMovie!.filter({ (value) -> Bool in
                            
                            dashboardVM.filterDataFormLocal(value: value)
                            
                        }), id: \.uniqueID) { value in
                            
                            SearchCardView(data: value, dashboardVM: dashboardVM)
                            
                        }
                    }
                    
                    ForEach(upcomingMovie, id : \.self) {  item in
                        ForEach(item.upcomingMovie!.filter({ (value) -> Bool in
                            
                            dashboardVM.filterDataFormLocal(value: value)
                            
                        }), id: \.uniqueID) { value in
                            SearchCardView(data: value, dashboardVM: dashboardVM)
                        }
                    }
                }
                .padding(.top, 16)
            }
            .padding(.top, 8)
            
        }
        .onTapGesture {
            hideKeyboard()
        }
        .ignoresSafeArea(.container, edges: .bottom)
        
    }
    
    var navigationBarWithSearchBar : some View {
        HStack{
            Button(action : {
                dashboardVM.entredDataForSearch = ""
                dashboardVM.presentFilterView = false
            }){
                Image(systemName: "arrow.backward")
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .foregroundColor(.blue)
                    .shadow(color: Color.white.opacity(0.6), radius: 6, x: 0.0, y: 0.0)
                
            }
            
            ZStack{
                
                Color.black
                    .opacity(0.1)
                    .frame(width: nil, height: 38, alignment: .center)
                    .cornerRadius(30)
                
                
                
                TextField(dashboardVM.keyboardType == .numeric ? "Search by year" : "Search by name", text: $dashboardVM.entredDataForSearch)
                    .keyboardType(dashboardVM.keyboardType == .numeric ? .numberPad : .alphabet)
                    .padding(.leading, 16)
                
            }
            
            Menu {
                Button(action : {
                    dashboardVM.entredDataForSearch = ""
                    hideKeyboard()
                    dashboardVM.keyboardType = .numeric
                }){
                    Label("Search by Year", systemImage:
                            
                            dashboardVM.keyboardType == .numeric ? "checkmark" : "")
                    
                    
                }
                Button(action : {
                    dashboardVM.entredDataForSearch = ""
                    hideKeyboard()
                    
                    dashboardVM.keyboardType = .alphabet
                }){
                    Label("Search by Name", systemImage: dashboardVM.keyboardType == .alphabet ? "checkmark" : "")
                    
                }
                
            } label: {
                Image(systemName: "text.redaction")
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .foregroundColor(.blue)
                    .shadow(color: Color.white.opacity(0.6), radius: 6, x: 0.0, y: 0.0)
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
}
