//
//  SearchCardView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI

// TO DO: написать свой extension на подгрузку картинок
// Удалить KingFisher

struct SearchCardView : View {
    var data: MovieModel
    var dashboardVM: DashboardViewModel
    var body: some View{
        
        ZStack(alignment : .topLeading) {
            
            HStack(alignment : .bottom, spacing : 0) {
                VStack{
                    VStack(alignment : .leading, spacing : 3) {
                        Text(data.title!)
                            .font(.system(size: 20, weight: .semibold, design: .default))
                        Text(data.releaseDate!)
                        Text(dashboardVM.getGenreString(id: data.genre_ids!))
                        
                        RatingView(arcAngle: dashboardVM.getTheAcrForProgressBar(data : data), rating: "\(data.voteAverage ?? "0.0")",size: 32)
                    }.padding(.leading, 110)
                    .padding(.top, 8)
                    
                    //                    Text(data.overview!)
                }.frame(width: UIScreen.main.bounds.width - 16, height: 125, alignment: .topLeading)
                .background(Color.black.opacity(0.1))
                .cornerRadius(20, corners: .allCorners)
                .frame(width: UIScreen.main.bounds.width - 16, height: 150, alignment: .bottom)
                
                
            }.frame(width: nil, height: 150, alignment: .top)
            .padding(.horizontal,8)
            
            //
//            KFImage(URL(string: Formatter.urlForImage + data.posterPath!))
//                .resizable()
//                .frame(width: 100, height: 150, alignment: .top)
//                .aspectRatio(contentMode: .fit)
//                .background(Color.black.opacity(0.2))
//                .cornerRadius(20, corners: .allCorners)
//                .padding(.leading, 8)
            
            // Пока заглушка )
            // Нужно KingFisher удалить
            Image("poster")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(15)
            
            NavigationLink(
                destination: DetailsView(data: data, dashboardVM: dashboardVM)
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true),
                label: {
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                        }
                    }
                })
        }
    }
}

//struct SearchCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchCardView()
//    }
//}
