//
//  PopularMovieModel+CoreDataProperties.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//
//

import Foundation
import CoreData


extension PopularMovieModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PopularMovieModel> {
        return NSFetchRequest<PopularMovieModel>(entityName: "PopularMovieModel")
    }

    @NSManaged public var popularMovie: [MovieModel]?
    @NSManaged public var timeStamp: Date?
}

extension PopularMovieModel : Identifiable {}
