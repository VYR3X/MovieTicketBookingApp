//
//  CoreDataService.swift
//  MovieApp
//
//  Created by v.zhokhov on 12.09.2021.
//

import Foundation
import CoreData

// TO DO: сделать фабричный метод для сохраниея данных
// убрать UserDefaults нахер он нужен тут

final class CoreDataService {
    
    // Singleton
    static var shared = CoreDataService()
    // View contex
    private let viewContext = PersistenceContainer.shared.container.viewContext
   
    let apiCalledStatus = UserDefaults.standard
    
    func saveMovie(endPoing: MovieEndpoint, models: [MovieModel]) {
        switch endPoing {
        case .nowPlaying:
            print("Save now playing movie data")
        // Mодели core data
        //            let nowPlaying = NowPlaying(context: context)
        //            nowPlaying.nowPlayingMovie = models
        //            nowPlaying.timeStamp = Date()
        case .popular:
            print("Save popular movie data")
        // Mодели core data
        //            let popular = Popular(context: context)
        //            popular.popularMovie = models
        //            popular.timeStamp = Date()
        case .topRated:
            print("Save topRated movie data")
        // Mодели core data
        //            let topRated = TopRated(context: context)
        //            topRated.topRatedMovie = models
        //            topRated.timeStamp = Date()
        case .upcoming:
            print("Save upcoming movie data")
        // Mодели core data
        //            let upcoming = Upcoming(context: context)
        //            upcoming.upcomingMovie = models
        //            upcoming.timeStamp = Date()
        }
        
        do {
            try viewContext.save()
//            if !apiCalledStatus.bool(forKey: endPoing.description) {
//                apiCalledStatus.setValue(true, forKey: endPoing.description)
//            }
            print("Data success saved in memory")
        } catch {
            print("Error while saving\(error)")
        }
    }
}
