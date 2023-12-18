//
//  FavoritesController.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 12.12.2023.
//

import UIKit

class FavoritesController: EpisodesController {
  //ID персонажа : ID в Favorite
  var dictionaryOfID = [Int: Int]()

    override func viewDidLoad() {
      super.viewDidLoad()
      
      //настройка иконки таб бара
      let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "HeartButton"), tag: 1)
      self.tabBarItem = tabBarItem
      
      self.navigationController?.setNavigationBarHidden(false, animated: true)
      view.backgroundColor = .white
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.navigationItem.titleView = nil
    self.navigationItem.searchController = nil
    self.navigationItem.title = "Favorite episodes"
    self.navigationController?.navigationBar.shadowImage = nil
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dictionaryOfID.count
  }
  
  override func getResult() {
    episodes.makeRequestFavorite(complition: {
      dictionaryOfID = [:]
      for singleEpisode in episodes.requiredResult {
        dictionaryOfID[singleEpisode.value.character.id] = singleEpisode.key
      }
      print("в гет реквест \(dictionaryOfID)")
    })
  }
  
  override func deleteFromFavorite(charID: Int) {
    CoreDataManager.shared.deleteEpisode(withCharID: charID) {
      //удаляем связку ID для удаленного элемента
      episodes.requiredResult.removeValue(forKey: dictionaryOfID[charID]!)
      //уменьшаем FavoriteID в словаре, для элементов после удаленного
      reloadDictionary(withDelElement: charID)
    }
    
    func reloadDictionary(withDelElement: Int) {
      var dict = [Int: Int]()
      //получаем значение Favorite ID удаленного персонажа
      let delFavID = dictionaryOfID[withDelElement]!
      //удаляем связку удаленного персонажа
      dictionaryOfID.removeValue(forKey: withDelElement)
       
      for pairID in dictionaryOfID {
        if pairID.value > delFavID {
          dict[pairID.key] = pairID.value - 1
            print("передалось \(pairID.key) : \(pairID.value - 1)")
            CoreDataManager.shared.updataEpisode(withCharID: pairID.key, newFavoriteID: (pairID.value - 1), complition: {
                print("обновление11")
                self.getResult()
                self.episodesCollectionView.reloadData()
            })
        } else {
          dict[pairID.key] = pairID.value
        }
      }
      dictionaryOfID = dict
      print("del = \(delFavID), в dict = \(dictionaryOfID)")
    }
  }
  
  override func favoriteList(sender: CustomTapGestureRecognizer) {
    if let id = sender.takenEpisode?.character.id {
      deleteFromFavorite(charID: id)
      self.setupEpisodesCollectionView()
      self.referenceToFavorite!.episodes.requiredResult[Int((sender.takenEpisode?.character.url)!)!]!.isFavorite = false
      self.referenceToFavorite?.episodesCollectionView.reloadData()
      self.episodesCollectionView.reloadData()
    }
  }

}
