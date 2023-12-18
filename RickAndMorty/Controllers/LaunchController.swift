//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Dmitry Logvinov on 12.12.2023.
//

import UIKit

class LaunchController: UIViewController {
  
  //количество градусов поворота портала
  let degree = CGFloat(Double.pi)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    //добавляем изображения
    let logoImageView = Image().getViewLogo()
    let loadingImageView = Image().getViewLoading()
    view.addSubview(logoImageView)
    view.addSubview(loadingImageView)
    
    //устанавливаем констрейнты
    constraintsForImages()
    
    //создание экземпляров вью
    let episodesViewController = EpisodesController(isMain: true)
    let favoritesViewController = FavoritesController(isMain: false)
    episodesViewController.referenceToFavorite = favoritesViewController
    favoritesViewController.referenceToFavorite = episodesViewController
    //загрузка эпизодов
    episodesViewController.episodes.makeRequest()
    favoritesViewController.getResult()
    
    //запускаем анимацию портала и переходим на следующую сцену
    UIView.animate(withDuration: 3, animations: {
      loadingImageView.transform = CGAffineTransformMakeRotation(self.degree)
    }) {finished in
      showMainScene()
      //CoreDataManager.shared.deleteAllEpisodes()
    }
    
    //функция установки констрейнтов
    func constraintsForImages() {
      NSLayoutConstraint.activate([
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
        logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
      ])
      NSLayoutConstraint.activate([
        loadingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        loadingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        loadingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
        loadingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70)
      ])
    }
    
    //функция вызова главной сцены
    func showMainScene() {
      
      //создание навигейшн контроллеров
      let episodesNavigationController = UINavigationController(rootViewController: episodesViewController)
      let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
      
      //создание таб бара
      let tabBarVC = UITabBarController()
      tabBarVC.setViewControllers([episodesNavigationController, favoritesNavigationController], animated: true)
      favoritesViewController.loadViewIfNeeded()
      
      //показ главной сцены
      tabBarVC.modalPresentationStyle = .fullScreen
      self.present(tabBarVC, animated: true)
    }
  }
}

