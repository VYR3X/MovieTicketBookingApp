//
//  UpcomingMovieView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI

struct UpcomingMovieView : View {
    
    @ObservedObject var dashboardVM : DashboardViewModel
    @FetchRequest(entity: Upcoming.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Upcoming.timeStamp, ascending: true)])
    var upcomingMovie: FetchedResults<Upcoming>
    
    var body: some View{
        VStack(alignment  : .leading, spacing : 0) {
            Text("\(MovieEndpoint.upcoming.description)")
                .font(.system(size: 18, weight: .bold, design: .default))
                .padding(.leading, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment : .top,spacing : 20) {
                    
                    if upcomingMovie.count > 0{
                        ForEach(upcomingMovie) { item in
                            ForEach(item.upcomingMovie!) { value in
                                VStack {
                                    SmallCardView(value: value, dashboardVM: dashboardVM)
                                }.onAppear(perform: {
                                    
                                    let pageNumber = upcomingMovie.count + 1
                                    //Call api before last five data shown
                                    if upcomingMovie.last!.upcomingMovie![15] == value{
                                        dashboardVM.loadMoreData(endPoint: .upcoming, pageNumber: pageNumber)
                                    }
                                })
                            }.frame(width: 130, height: nil, alignment: .leading)
                            
                        }
                        
                    }
                }
                .padding(.leading, 20)
            }
            
        }
    }
}

//struct UpcomingMovieEndPointView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingMovieView()
//    }
//}
