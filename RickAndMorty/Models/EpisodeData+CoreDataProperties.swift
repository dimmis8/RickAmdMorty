//
//  EpisodeData+CoreDataProperties.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 17.12.2023.
//
//

import Foundation
import CoreData

@objc(EpisodeData)
public class EpisodeData: NSManagedObject {}


extension EpisodeData {
    @NSManaged public var episodeName: String?
    @NSManaged public var imageCharacter: Data?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String?
    @NSManaged public var charID: Int64
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var type: String?
    @NSManaged public var gender: String?
    @NSManaged public var originName: String?
    @NSManaged public var locationName: String?
    @NSManaged public var favoriteListID: Int64
    @NSManaged public var episodeID: Int64


}

extension EpisodeData: Identifiable {}
