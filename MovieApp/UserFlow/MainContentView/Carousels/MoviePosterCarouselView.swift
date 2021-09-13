//
//  MoviePosterCarouselView.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//

import SwiftUI

/// Карусель с вертикальными ячейками 
struct MoviePosterCarouselView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: SampleDetailView()) {
//                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            VStack(alignment : .leading, spacing: 10) {
                                MoviePosterCard(movie: movie)
                            }
                            .padding(.leading, 8)
                            .padding(.top, 16)
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
    }
}

struct MoviePosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCarouselView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}

