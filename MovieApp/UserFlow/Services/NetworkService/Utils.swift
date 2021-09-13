//
//  Utils.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import Foundation

final class Utils {
    
//    static let urlForImage = "https://image.tmdb.org/t/p/w500"
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        // если я правильно понял это чтобы в модели не создавать coding key 
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    static let genreIDValues: [Int : String] = [
        28 : "Action",
        16 : "Animated",
        99 : "Documentary",
        18 : "Drama",
        10751 : "Family",
        14 : "Fantasy",
        36 : "History",
        35 : "Comedy",
        10752 : "War",
        80 : "Crime",
        10402 : "Music",
        9648 : "Mystery",
        10749 : "Romance",
        878 : "Sci-Fi",
        27 : "Horror",
        10770 : "TV Movie",
        53 : "Thriller",
        37 : "Western",
        12 : "Adventure"
    ]
}

