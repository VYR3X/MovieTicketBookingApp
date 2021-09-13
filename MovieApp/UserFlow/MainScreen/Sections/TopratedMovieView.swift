//
//  TopratedMovieView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI

struct TopratedMovieView: View {
    
    @ObservedObject var dashboardVM : DashboardViewModel
    
//    @FetchRequest(entity: TopRatedMovieModel.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TopRatedMovieModel.timeStamp, ascending: true)])
//
//    var topratedMovie: FetchedResults<TopRatedMovieModel>
    
    var body: some View {
        VStack(alignment  : .leading, spacing : 0) {
            
            Text("\(MovieEndpoint.topRated.description)")
                .font(.system(size: 18, weight: .bold, design: .default))
                .padding(.leading, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment : .top, spacing : 20)  {
                    
//                    if topratedMovie.count > 0{
//                        ForEach(topratedMovie) { item in
//                            ForEach(item.topRatedMovie!) { value in
//                                VStack{
//                                    SmallCardView(value: value, dashboardVM: dashboardVM)
//                                }.onAppear(perform: {
//
//                                    let pageNumber = topratedMovie.count + 1
//                                    //Call api before last five data shown
//                                    if topratedMovie.last!.topRatedMovie![15] == value{
//                                        dashboardVM.loadMoreData(endPoint: .topRated, pageNumber: pageNumber)
//                                    }
//                                })
//                            }.frame(width: 130, height: nil, alignment: .leading)
//                        }
//                    }
                    
                    // Убрать сохранение данных в кор дате )
                    let models = dashboardVM.resultModel
                     
                    ForEach(models) { model in
                        VStack {
                            SmallCardView(value: model, dashboardVM: dashboardVM)
                        }
                    }
                    
                }
                .padding(.leading, 20)
            }
            
        }
    }
}

//struct TopratedMovieEndPointView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopratedMovieView()
//    }
//}
