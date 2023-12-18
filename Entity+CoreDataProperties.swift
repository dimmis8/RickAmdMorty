//
//  Entity+CoreDataProperties.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 17.12.2023.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var attribute: Data?

}

extension Entity : Identifiable {

}
