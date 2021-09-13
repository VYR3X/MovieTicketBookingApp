//
//  TopRatedMovieModel+CoreDataProperties.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//
//

import Foundation
import CoreData


extension TopRatedMovieModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopRatedMovieModel> {
        return NSFetchRequest<TopRatedMovieModel>(entityName: "TopRated")
    }

    @NSManaged public var topRatedMovie: [MovieModel]?
    @NSManaged public var timeStamp: Date?
}

extension TopRatedMovieModel : Identifiable {}
