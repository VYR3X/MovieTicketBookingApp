//
//  SmallCardView.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import SwiftUI
//import Kingfisher

struct SmallCardView: View {
    
    var value: MovieModel
    @ObservedObject var dashboardVM: DashboardViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment : .leading, spacing : 10) {
//                KFImage.url(URL(string: Utils.urlForImage + value.posterPath!))
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 130, height: 180, alignment: .center)
//                    .background(Color.black.opacity(0.2))
//                    .cornerRadius(10)
//                    .padding(.top, 16)
//                    .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0.0, y: 0.0)
                Image("poster")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(15)
                
                VStack(alignment : .leading, spacing : 2) {
                    
                    // Название фильма
                    Text("\(value.title ?? "Not found")")
                        .font(.system(size: 12, weight: .semibold, design: .default))
                    
                    // Жанр фильма
                    Text("\(dashboardVM.getGenreString(id: value.genre_ids!))")
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.system(size: 12, weight: .semibold, design: .default))
                        .foregroundColor(Color.black.opacity(0.3))
                        .frame(width: nil, height: 30, alignment: .leading)
                }
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
