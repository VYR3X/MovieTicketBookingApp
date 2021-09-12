//
//  DashboardViewModel.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import Foundation
//import CoreData
import UIKit

// Выбор типа клавиатуры для отображения
enum KeyboardType {
    case numeric
    case alphabet
}

// Класс для работы с Core Data
// сохранение и выгрузка данных из хранилища
class DashboardViewModel: ObservableObject {
    
    @Published var presentDetailsView: Bool = false
    @Published var imageSaved = false
    @Published var presentFilterView = false
    @Published var entredDataForSearch = ""
    @Published var keyboardType: KeyboardType = .numeric
    
    // Api Service
    private var networkService: NetworkService
    // View contex
//    private let context = PersistenceContainer.shared.container.viewContext
    // EndPoint
    private var endPoint: MovieEndpoint = .nowPlaying
    
    init(service: NetworkService) {
        
        self.networkService = service
        
        let apiCalledStatus = UserDefaults.standard
        
        print("value required \(apiCalledStatus.bool(forKey: "\(MovieEndpoint.upcoming.description)"))")
        
        if !apiCalledStatus.bool(forKey: "\(MovieEndpoint.nowPlaying.description)") {
            fetchMovie(endPoint: .nowPlaying, page: 1)
        }
        
        if !apiCalledStatus.bool(forKey: "\(MovieEndpoint.upcoming.description)") {
            fetchMovie(endPoint: .upcoming, page: 1)
        }
        
        if !apiCalledStatus.bool(forKey: "\(MovieEndpoint.popular.description)") {
            fetchMovie(endPoint: .popular, page: 1)
        }
        
        if !apiCalledStatus.bool(forKey: "\(MovieEndpoint.topRated.description)") {
            fetchMovie(endPoint: .topRated, page: 1)
        }
    }
    
    // internal access
    func loadMoreData(endPoint: MovieEndpoint, pageNumber : Int){
        fetchMovie(endPoint: endPoint, page: pageNumber)
    }
    
    /// Получаем строку: Жанр фильма
    func getGenreString(id genreId: [Int]) -> String {
        return genreId.map({ (value) -> String in
            return Formatter.genreIDValues[value]!
        }).joined(separator: ", ")
    }
    
    // Получение значения рейтинга фильма
    func getTheAcrForProgressBar(data: MovieModel) -> CGFloat{
        return CGFloat(((10.0 - Double(data.voteAverage!)!) / 10.0))
    }
    
    // internal
    func filterDataFormLocal(value: MovieModel) -> Bool {
        if entredDataForSearch == "" {
            return true
        } else {
            if keyboardType == .alphabet {
                return value.title!.localizedCaseInsensitiveContains("\(entredDataForSearch)")
            } else {
                return value.releaseDate!.prefix(4).localizedCaseInsensitiveContains("\(entredDataForSearch)")
            }
        }
    }
    
    // Сохраняем постер в фотоальбом устройства
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        imageSaved = true
        print("")
    }
    
    // ????
    private func changeKeyboardType(type : KeyboardType) {
        keyboardType = type
    }
    
    private func fetchMovie(endPoint: MovieEndpoint, page: Int) {
        
        networkService.fetchMovies(endPoint: endPoint, page: page) { result in
            switch result {
            case .success(let models):
                self.saveDataInMemory(movieList: models)
//                Database.shared.saveMovie(endPoing: endPoint, listOfMovie: data)
            case .failure(let error):
                print("error on fail : \(error)")
            }
        }
    }
    
    private func saveDataInMemory(movieList: [MovieModel]) {
        CoreDataService.shared.saveMovie(endPoing: endPoint, models: movieList)
    }
}
