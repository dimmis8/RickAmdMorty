//
//  Model.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 13.12.2023.
//

import UIKit
import CoreData
import Foundation

class Request {
  var episodesFromRequest = [Result]()
  var requiredResult = [Int: RequiredResult]()
  
  //функция запроса
  func makeRequest(){
    let request = URLRequest(url: URL(string: "https://rickandmortyapi.com/api/episode")!)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data, let episode = try? JSONDecoder().decode(Episode.self, from: data) {
        self.episodesFromRequest = episode.results
        self.getRequiredResult()
      }
    }
    //запуск запроса
    task.resume()
  }
  
  //функция получения данных о фаворитах
  func makeRequestFavorite(complition: () -> ()){
    CoreDataManager.shared.fetchEpisodes { favoriteFromStorage in
      for favorite in favoriteFromStorage {
        
        guard let imageData = favorite.imageCharacter else {
          print("ИЗОБРАЖЕНИЕ НЕ ПРИШЛО!")
          return
        }
        self.requiredResult[Int(favorite.favoriteListID)] = RequiredResult(episodeName: favorite.episodeName!,
                                                    character: Characters(id: Int(favorite.charID),
                                                                          name: favorite.name!,
                                                                          status: favorite.status!,
                                                                          species: favorite.species!,
                                                                          type: favorite.type!,
                                                                          gender: favorite.gender!,
                                                                          origin: Location(name: favorite.originName!, url: ""),
                                                                          location: Location(name: favorite.locationName!, url: ""),
                                                                          image: "",
                                                                          episode: [],
                                                                          url: "\(favorite.episodeID)",
                                                                          created: ""),
                                                    imageCharacter: imageData,
                                                    isFavorite: favorite.isFavorite)
      }
    }
    complition()
  }
  
  //получение информации для ячеек
  private func getRequiredResult() {
    for episode in episodesFromRequest {
      let character = episode.characters.randomElement()!
      getImage(characterURL: character) {infoCharacter, image in
        self.requiredResult[episode.id] = RequiredResult(episodeName: (episode.episode + " | " + episode.name), character: infoCharacter, imageCharacter: image)
      }
    }
  }

  //получение изображений
  private func getImage(characterURL: String, completion: @escaping (Characters, Data) ->()) {
      var imageURL = String()
      
      let request = URLRequest(url: URL(string: characterURL)!)
      let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data, let character = try? JSONDecoder().decode(Characters.self, from: data) {
          
          DispatchQueue.main.async {
            imageURL = character.image
            let request = URLRequest(url: URL(string: imageURL)!)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data, error == nil else { return }
              let image = UIImage(data: data)!
              let imageData = image.jpegData(compressionQuality: 1.0)
              completion(character, imageData!)
            }
            task.resume()
          }
        }
      }
      //запуск запроса
      task.resume()
    }
  }

