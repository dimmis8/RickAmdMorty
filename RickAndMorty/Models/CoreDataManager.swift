//
//  CoreDataManager.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 17.12.2023.
//

import UIKit
import CoreData


public final class CoreDataManager: NSObject {
  public static let shared = CoreDataManager()
  private override init() {}
  
  private var appDelegate: AppDelegate {
    UIApplication.shared.delegate as! AppDelegate
  }
  
  private var context: NSManagedObjectContext {
    appDelegate.persistentContainer.viewContext
  }
  
  //сохранение
  public func createEpisode(episodeName: String?, imageCharacter: Data?, isFavorite: Bool?, name: String?, charID: Int, status: String?, species: String?, type: String?, gender: String?, originName: String?, locationName: String?, favoriteListID: Int, episodeID: Int) {
    //описание объекта
    guard let episodeEntityDescription = NSEntityDescription.entity(forEntityName: "EpisodeData", in: context) else {
      return
    }
    //создание объекта по контексту
    let episode = EpisodeData(entity: episodeEntityDescription, insertInto: context)
    episode.episodeName = episodeName
    episode.imageCharacter = imageCharacter
    episode.isFavorite = isFavorite ?? false
    episode.name = name
    episode.charID = Int64(charID)
    episode.status = status
    episode.species = species
    episode.type = type
    episode.gender = gender
    episode.originName = originName
    episode.locationName = locationName
    episode.favoriteListID = Int64(favoriteListID)
    episode.episodeID = Int64(episodeID)
    
    appDelegate.saveContext()
  }
  
  //получение
  //public func fetchEpisodes() -> [EpisodeData] {
  public func fetchEpisodes(completion: @escaping ([EpisodeData]) ->()) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EpisodeData")
    do {
      completion((try? context.fetch(fetchRequest) as? [EpisodeData]) ?? [])
    }
  }
  
  //удаление эпизодов
  public func deleteAllEpisodes() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EpisodeData")
    do{
      let episodes = try? context.fetch(fetchRequest) as? [EpisodeData]
      episodes?.forEach { context.delete($0)}
    }
    appDelegate.saveContext()
  }
  //удаление эпизода
  public func deleteEpisode(withCharID charID: Int, completion: () -> ()) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EpisodeData")
    do{
        guard let episodes = try? context.fetch(fetchRequest) as? [EpisodeData],
              let episode = episodes.first(where: {$0.charID == charID})  else {
          return }
        context.delete(episode)
      completion()
    }
    appDelegate.saveContext()
  }
  
  //обновление значения idFavorite у эпизода
  public func updataEpisode(withCharID charID: Int, newFavoriteID: Int, complition: () -> ()) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EpisodeData")
    do {
      guard let episodes = try? context.fetch(fetchRequest) as? [EpisodeData],
            let episode = episodes.first(where: {$0.charID == charID})  else {
        print("попался \(charID)")
        return }
      episode.favoriteListID = Int64(newFavoriteID)
      complition()
    }
    appDelegate.saveContext()
  }
  
  
  
}

