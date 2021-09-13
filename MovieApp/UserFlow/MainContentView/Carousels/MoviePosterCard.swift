//
//  MoviePosterCard.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//

import SwiftUI

/// Изобржение постера в вертикальном формате
struct MoviePosterCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Poster view with subviews
            ZStack {
                if self.imageLoader.image != nil {
                    // Постер с рейтингом
                    ZStack {
                        Image(uiImage: self.imageLoader.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                        Text("\(movie.averageRating)")
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .padding(.top, 220)
                            .padding(.trailing, 120)
                    }
                // Заглушка ( отображается пока постер не подгрузится )
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                    
                    Text(movie.title)
                        .multilineTextAlignment(.center)
                }
            }
            // Размер постера
            .frame(width: 200, height: 300)
            // Название фильма
            Text("\(movie.title)")
                .font(.system(size: 22, weight: .bold, design: .default))
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                .frame(width: 200)
//                .lineLimit(2)
            // Жанр фильма
            Text("\(movie.genreText)")
                .font(.system(size: 20, weight: .regular, design: .default))
                .foregroundColor(Color.black.opacity(0.4))
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.stubbedMovie)
    }
}

