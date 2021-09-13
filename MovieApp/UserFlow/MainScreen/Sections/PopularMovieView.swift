//
//  PopularMovieView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI

struct PopularMovieView : View {
    
    @ObservedObject var dashboardVM: DashboardViewModel
    @FetchRequest(entity: PopularMovieModel.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \PopularMovieModel.timeStamp, ascending: true)])
    
    var popularMovies: FetchedResults<PopularMovieModel>
    
    var body: some View{
        VStack(alignment  : .leading, spacing : 0) {
            Text("\(MovieEndpoint.popular.description)")
                .font(.system(size: 18, weight: .bold, design: .default))
                .padding(.leading, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment : .top,spacing : 20) {
                    if popularMovies.count > 0{
                        ForEach(popularMovies) { item in
                            ForEach(item.popularMovie!) { value in
                                SmallCardView(value: value, dashboardVM: dashboardVM)
                                    .onAppear(perform: {
                                        
                                        let pageNumber = popularMovies.count + 1
                                        //Call api before last five data shown
                                        if popularMovies.last!.popularMovie![15] == value{
                                            dashboardVM.loadMoreData(endPoint: .popular, pageNumber: pageNumber)
                                        }
                                    })
                            }
                            .frame(width: 130, height: nil, alignment: .leading)
                        }
                    }
                }
                .padding(.leading, 20)
            }
        }
    }
}

//struct PopularMovieEndPointView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopularMovieView()
//    }
//}
