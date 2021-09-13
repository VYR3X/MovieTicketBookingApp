//
//  NetworkService.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import Foundation
import CoreData

// Протокол для работы с сетевым сервисов
protocol MovieService {
    func fetchMovies(endPoint: MovieEndpoint,
                     page: Int,
                     completionHangler: @escaping (Result<[MovieModel], MovieError>) -> ())
    
}

// Класс для работы с сетью
final class NetworkService: MovieService {
    
    private let apiKey = "" // API_KEY
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    
    func fetchMovies(endPoint: MovieEndpoint,
                     page: Int,
                     completionHangler: @escaping (Result<[MovieModel], MovieError>) -> ()) {
        
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endPoint.rawValue)?api_key=\(apiKey)&page=\(page)") else {
            completionHangler(.failure(.invalidEndpoint))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else{
                print("No inter connection found")
                completionHangler(.failure(.noData))
                return
            }
            
//            let parent = PersistenceContainer.shared.container.viewContext
//            let childContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//            childContext.parent = parent
            
            do {
                // JSONDecoder с возможностью сохранения данных в Core Data
//                let decoder = JSONDecoder(context: childContext)
                // Обычный декодер
                let simpleJSONDecoder = JSONDecoder()
                
                switch endPoint{
                case .nowPlaying:
                    print("Network manager success fetch moview model and Save in core data")
//                    let model  =  try decoder.decode(NowPlayingModel.self, from: data)
                    let model = try simpleJSONDecoder.decode([MovieModel].self, from: data)
//                    completionHangler(.success(model.movie!))
                    completionHangler(.success(model))
                case .popular:
                    print("Network manager success fetch moview model and Save in core data")
//                    let model  =  try decoder.decode(PopularMovieModel.self, from: data)
                    let model  =  try simpleJSONDecoder.decode([MovieModel].self, from: data)
//                    completionHangler(.success(model.popularMovie!))
                    completionHangler(.success(model))
                case .topRated:
                    print("Network manager success fetch moview model and Save in core data")
//                    let model  =  try decoder.decode(TopRatedMovieModel.self, from: data)
                    let model  =  try simpleJSONDecoder.decode([MovieModel].self, from: data)
//                    completionHangler(.success(model.topRatedMovie!))
                    completionHangler(.success(model))
                case .upcoming:
                    print("Network manager success fetch moview model and Save in core data")
//                    let model  =  try decoder.decode(Upcoming.self, from: data)
                    let model  =  try simpleJSONDecoder.decode([MovieModel].self, from: data)
//                    completionHangler(.success(model.upcomingMovie!))
                    completionHangler(.success(model))
                }
            } catch {
                print("Error while decoding \(error)")
                completionHangler(.failure(.serializationError))
            }
        }
        task.resume()
    }
}


// MARK: - JSONDecoder extension

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.managedObjectContext] = context
    }
}
