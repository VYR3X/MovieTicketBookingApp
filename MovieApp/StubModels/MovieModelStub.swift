//
//  OldMovieModel.swift
//  MovieApp
//
//  Created by v.zhokhov on 09.09.2021.
//

import SwiftUI

// Sample movie data

var synopsis = "Джеймс Бонд оставил оперативную службу и наслаждается спокойной жизнью на Ямайке. Все меняется, когда на острове появляется его старый друг Феликс Лейтер из ЦРУ с просьбой о помощи. Миссия по спасению похищенного ученого оказывается опаснее, чем предполагалось изначально. Бонд попадает в ловушку к таинственному злодею, вооруженному опасным технологическим оружием."

var genre = ["mystery" , "thriller", "adventure", "action"]

var time = ["10:00", "11:30", "13:00", "14:30", "16:00", "17:30", "19:00"]


extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
}

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
