//
//  NowPlayingModel+CoreDataProperties.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//
//

import Foundation
import CoreData


extension NowPlayingModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NowPlayingModel> {
        return NSFetchRequest<NowPlayingModel>(entityName: "NowPlayingModel")
    }

    @NSManaged public var movie: [MovieModel]?
    @NSManaged public var timeStamp: Date?

}

extension NowPlayingModel : Identifiable {}
