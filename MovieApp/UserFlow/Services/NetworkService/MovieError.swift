//
//  MovieError.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import Foundation

/// Сетевые ошибки
enum MovieError: Error, CustomNSError {
    
    /// Ошибка при выполнении dataTask
    case apiError
    /// Неверный  endpoint
    case invalidEndpoint
    /// Некоректный ответ от сервера ( 400 ошибка ) 
    case invalidResponse
    /// Данные не пришли
    case noData
    /// Проблема сериализации
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
