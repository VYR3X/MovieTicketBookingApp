//
//  MovieDetailState.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//

import SwiftUI

class MovieDetailState: ObservableObject {
    
    private let networkService: NetworkServiceProtocol
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        
        self.networkService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
