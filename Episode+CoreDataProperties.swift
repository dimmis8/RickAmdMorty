//
//  Episode+CoreDataProperties.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 17.12.2023.
//
//

import Foundation
import CoreData


extension Episode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Episode> {
        return NSFetchRequest<Episode>(entityName: "Episode")
    }

    @NSManaged public var episodeName: String?
    @NSManaged public var imageCharacter: Date?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var type: String?
    @NSManaged public var gender: String?
    @NSManaged public var originName: String?
    @NSManaged public var locationName: String?

}

extension Episode : Identifiable {

}
