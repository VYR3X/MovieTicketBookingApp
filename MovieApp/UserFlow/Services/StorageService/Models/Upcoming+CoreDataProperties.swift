//
//  Upcoming+CoreDataProperties.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//
//

import Foundation
import CoreData


extension Upcoming {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Upcoming> {
        return NSFetchRequest<Upcoming>(entityName: "Upcoming")
    }

    @NSManaged public var upcomingMovie: [MovieModel]?
    @NSManaged public var timeStamp: Date?
}

extension Upcoming : Identifiable {}
