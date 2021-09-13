//
//  Upcoming+CoreDataClass.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//
//

import Foundation
import CoreData

@objc(Upcoming)
public class Upcoming: NSManagedObject, Decodable{

    
    enum CodingKeys: String, CodingKey {
        case upcomingMovie = "results"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: "Upcoming", in: context) else {
              throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(entity: entity, insertInto: context)
//        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        upcomingMovie = try container.decode([MovieModel].self, forKey: .upcomingMovie)
    }
}
