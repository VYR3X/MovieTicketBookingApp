//
//  NetworkService.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//

import Foundation

/// Протокол для взаимодействия с сетевым сервисом
protocol NetworkServiceProtocol {
    
    /// Получение фильмов
    /// - Parameters:
    ///   - endpoint: endpoint запроса
    ///   - completion: блок завершения
    func fetchMovies(from endpoint: MovieEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    
    /// Получение фильма
    /// - Parameters:
    ///   - id: id фильма
    ///   - completion: блок завершения
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    
    /// Получение фильма после поиска
    /// - Parameters:
    ///   - query: параметры запроса
    ///   - completion: блок завершения
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

/// Сервис для работы с сетевыми запросами
final class NetworkService {
    
    // Синглтон сервиса
    static let shared = NetworkService()
    private init() {}
    
    private lazy var baseAPIURL = String(configData("Base API URL") ?? "")
    
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    private func loadURLAndDecode<D: Decodable>(url: URL,
                                                params: [String: String]? = nil,
                                                completion: @escaping (Result<D, MovieError>) -> ()) {
        
        /// 1. Собираем URL покомпонентно
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        /// 2. Параметры запроса ( APIKEY ) + опционально доп. параметры
        var queryItems = [URLQueryItem(name: "api_key", value: configData("MovieDB API Key"))]
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        urlComponents.queryItems = queryItems
        
        /// 3. Получаем готовый урл из наших компонентов
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.asyncExecution(with: .failure(.apiError), completion: completion)
                return
            }
            
            /// Статус ответа от сервера
            /// Если statusCode находится в пределах от 200 до 300 то все отлично )
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.asyncExecution(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            /// Данные не пришли
            guard let data = data else {
                self.asyncExecution(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.asyncExecution(with: .success(decodedResponse), completion: completion)
            } catch {
                self.asyncExecution(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    // Асинхронная выгрузка данных
    private func asyncExecution<D: Decodable>(with result: Result<D, MovieError>,
                                                                    completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    // Получение данных из конфигурационного файла
    private func configData(_ key: String) -> String? {
        guard let resultValue = (Bundle.main.infoDictionary?[key] as? String) else { return nil }
        return resultValue.replacingOccurrences(of: "#", with: "//")
     }
}


// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    
    func fetchMovies(from endpoint: MovieEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "append_to_response": "videos,credits"
        ], completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ], completion: completion)
    }
}
