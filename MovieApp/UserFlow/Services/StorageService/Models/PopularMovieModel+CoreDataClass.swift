//
//  PopularMovieModel+CoreDataClass.swift
//  MovieApp
//
//  Created by v.zhokhov on 13.09.2021.
//
//

import Foundation
import CoreData

@objc(PopularMovieModel)
public class PopularMovieModel: NSManagedObject, Decodable {
//    public func encode(with coder: NSCoder) {
//        coder.encode(popularMovie, forKey : "results")
//    }
    
//    public func encode(to encoder: Encoder) throws {
//
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(popularMovie, forKey: .popularMovie)
//    }
    

    public static var supportsSecureCoding = true
    
    enum CodingKeys : String, CodingKey{
        case popularMovie = "results"
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: "PopularMovieModel", in: context) else {
              throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(entity: entity, insertInto: context)
//        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // 
        popularMovie = try container.decodeIfPresent([MovieModel].self, forKey: .popularMovie)
    }
}

