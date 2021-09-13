//
//  LargeCardView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI
//import Kingfisher

struct LargeCardView: View {
    
    var value: MovieModel
    var nowPlayingMovies: FetchedResults<NowPlayingModel>
    @ObservedObject var dashboardVM: DashboardViewModel
    
    var body : some View {
        ZStack{
            VStack(alignment : .leading) {
                VStack {
                    //                    KFImage.url(URL(string: Utils.urlForImage + value.posterPath!))
                    //                        .resizable()
                    //                        .aspectRatio(contentMode: .fill)
                    //                        .frame(width: UIScreen.main.bounds.width / 1.4, height: (UIScreen.main.bounds.height / 1.7), alignment: .top)
                    //                        .background(Color.black.opacity(0.2))
                    Image("poster")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(15)
                }
                .foregroundColor(.white)
                .background(Color.black.opacity(0.1))
                .cornerRadius(30)
                .padding(.top, 16)
                .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0.0, y: 0.0)
                
                .onAppear(perform: {
                    let pageNumber = nowPlayingMovies.count + 1
                    //Call api before last five data shown
                    if nowPlayingMovies.last!.movie![15] == value{
                        dashboardVM.loadMoreData(endPoint: .nowPlaying, pageNumber: pageNumber)
                    }
                })
                VStack(alignment : .leading, spacing : 2) {
                    
                    // Название фильма
                    Text("\(value.title ?? "Title not available")")
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    // Жанр фильма
                    Text("\(dashboardVM.getGenreString(id: value.genre_ids!))")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(Color.black.opacity(0.4))
                }
                .padding(.leading, 8)
                .padding(.top, 16)
            }
            
            NavigationLink(
                destination: DetailsView(data: value, dashboardVM: dashboardVM),
                label: {
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                        }
                    }
                })
        }
    }
}

//struct LargeCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        LargeCardView()
//    }
//}

