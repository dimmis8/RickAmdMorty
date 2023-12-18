//
//  EpisodesController.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 12.12.2023.
//

import UIKit

class EpisodesController: UIViewController, UIGestureRecognizerDelegate {
  
  //view с лого
  let logoImageView: UIImageView? = Image().getViewLogo() as? UIImageView
  let serachBar = UITextField()
  let filtersButton = UIButton(type: .system)
  //collection view
  var episodesCollectionView: UICollectionView!
  var episodes = Request()
  //переменная объявлена вне метода настройки айтемов, чтобы ее можно было передать в детали
  var currentEpisodeId = Int()
  var referenceToFavorite: EpisodesController?
  var mainController: Bool?
  var constraintForColection: Int?
  
  init(isMain: Bool) {
    self.mainController = isMain
    if isMain {
      constraintForColection = 210
    } else {
      constraintForColection = 0
    }
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      //настройка иконки таб бара
      let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "HomeButton"), tag: 0)
      self.tabBarItem = tabBarItem
      view.backgroundColor = .white
      //добавляем лого, поиск, выставляем констрейнты
      if mainController! {
        setupBar()
      }
      //настройка колекшн вью
      setupEpisodesCollectionView()
    }
  
  //добавляем скрытие нав бара при поялвении сцены и включаем отображение при уходе со сцены
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: true)
    super.viewWillAppear(animated)
  }
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    super.viewWillDisappear(animated)
  }
  
  //MARK: - setupBar and setupEpisodesCollectionView
  
  private func setupBar() {
    view.addSubview(logoImageView!)
    setupSearchBar()
    view.addSubview(serachBar)
    constraintsForImage()
    constraintForSearchBar()
    setupButton()
    view.addSubview(filtersButton)
    constraintsForButton()
    
    
    
    func setupSearchBar() {
      self.serachBar.placeholder = "Name or episode (ex.S01E01)..."
      self.serachBar.borderStyle = .roundedRect
      self.serachBar.layer.borderWidth = 1
      self.serachBar.layer.borderColor = UIColor.lightGray.cgColor
      self.serachBar.layer.cornerRadius = 8
      let imageView = UIImageView(image: UIImage(named: "SearchIcon"))
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      self.serachBar.leftView = imageView
      self.serachBar.leftViewMode = .always
      self.serachBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupButton() {
      self.filtersButton.setTitle("ADVSNCED FILTERS", for: .normal)
      self.filtersButton.setTitleColor(UIColor(red: 0.12, green: 0.58, blue: 0.96, alpha: 1), for: .normal)
      self.filtersButton.layer.cornerRadius = 9
      self.filtersButton.backgroundColor = UIColor(red: 0.89, green: 0.95, blue: 1, alpha: 1)
      self.filtersButton.translatesAutoresizingMaskIntoConstraints = false
      let image = UIImage(named: "details")
      self.filtersButton.setImage(image, for: .normal)
      self.filtersButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 50)
      self.filtersButton.layer.shadowColor = UIColor.lightGray.cgColor
      self.filtersButton.layer.shadowRadius = 2
      self.filtersButton.layer.shadowOpacity = 2
      self.filtersButton.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    //установка констрейнтов для логотипа
    func constraintsForImage() {
      NSLayoutConstraint.activate([
        logoImageView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        logoImageView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
        logoImageView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
        logoImageView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
      ])
    }
    func constraintForSearchBar() {
      NSLayoutConstraint.activate([
        serachBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
        serachBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
        serachBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
        serachBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
      ])
    }
    func constraintsForButton() {
      NSLayoutConstraint.activate([
        filtersButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160),
        filtersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
        filtersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
        filtersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
      ])
    }
  }

  //установка коллекции
  func setupEpisodesCollectionView() {
    
    episodesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
    //добавляем колекшн вью на вью
    view.addSubview(episodesCollectionView)
    episodesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    //создаем констрейнты
    NSLayoutConstraint.activate([
      episodesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(constraintForColection!)),
      episodesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      episodesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      episodesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
    ])
    //подписание на протокол, для добавления контента
    episodesCollectionView.dataSource = self
    //регистрация ячейки
    episodesCollectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: "\(EpisodeCell.self)")
  }
   
  func setupFlowLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    //установка размера ячейки
    layout.itemSize = .init(width: 300, height: 370)
    //расстояние между ячейками
    layout.minimumLineSpacing = 10
    //расстояние до ближайших элементов от ячейки
    layout.sectionInset = .init(top: 20, left: 0, bottom: 30, right: 0)
    return layout
  }
  
  func deleteFromFavorite(charID: Int){}
  func getResult() {}
}

//MARK: -Extensions

//расширение класса для добавления контента в колекшн вью
extension EpisodesController: UICollectionViewDataSource {

  //определение айтемов в секции
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    episodes.episodesFromRequest.count
  }
  //метод для настройки айтемов
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = episodesCollectionView.dequeueReusableCell(withReuseIdentifier: "\(EpisodeCell.self)", for: indexPath) as? EpisodeCell else {
      return UICollectionViewCell()
    }
    //определяем id эпизода текущей ячейки
    currentEpisodeId = indexPath.row + 1
    
    //добавление контента в ячейку
    if let dataImage = episodes.requiredResult[currentEpisodeId]?.imageCharacter {
      cell.imageView.image = UIImage(data: dataImage)
    } else {
      cell.imageView.image = UIImage(named: "errorImage")
    }
    cell.labelView.text = (episodes.requiredResult[currentEpisodeId]?.episodeName)
    cell.labelNameView.text = ("    " + (episodes.requiredResult[currentEpisodeId]?.character.name ?? "NO DATA"))
    cell.labelSpecies.text = episodes.requiredResult[currentEpisodeId]?.character.species
    if episodes.requiredResult[currentEpisodeId]?.isFavorite == true {
      cell.heartIcon.image = UIImage(named: "RedHeartButton")
    } else {
      cell.heartIcon.image = UIImage(named: "HeartButton")
    }
    
    //добавляем возможность нажатия на картинку
    let tapImage = CustomTapGestureRecognizer(target: self, action: #selector(showDetails(sender:)))
    if let result = episodes.requiredResult[currentEpisodeId] {
      tapImage.takenEpisode = result
      tapImage.delegate = self
      cell.imageView.isUserInteractionEnabled = true
      cell.imageView.addGestureRecognizer(tapImage)
    }
    
    //добавляем возможность нажатия на сердце
    let tapHeart = CustomTapGestureRecognizer(target: self, action: #selector(favoriteList(sender:)))
    if let result = episodes.requiredResult[currentEpisodeId] {
      tapHeart.takenEpisode = result
      tapHeart.episodeID = currentEpisodeId
      tapHeart.indx = indexPath.row
      tapHeart.viewToAnimate = cell.heartIcon
      tapHeart.delegate = self
      cell.heartIcon.isUserInteractionEnabled = true
      cell.heartIcon.addGestureRecognizer(tapHeart)
    }
    return cell
  }
  
//MARK: -Setup for buttons
  
  //функция отработки нажатия на картинку
  @objc func showDetails(sender: CustomTapGestureRecognizer) {
    //создаем экземпляр вью деталей
    let detailsController = DetailsController()
    //передаем данные по персонажу
    detailsController.episode = sender.takenEpisode!
    //переходим на страницу с деталями
    self.navigationController?.pushViewController(detailsController, animated: true)
  }

  
  //функция смены фаварита
  @objc func favoriteList(sender: CustomTapGestureRecognizer) {

    episodes.requiredResult[sender.episodeID!]!.isFavorite = !(episodes.requiredResult[sender.episodeID!]!.isFavorite)
    
    DispatchQueue.main.async {
      self.episodesCollectionView.reloadData()
      if self.episodes.requiredResult[sender.episodeID!]!.isFavorite == true {
        var idForFacorite: Int?
        
        CoreDataManager.shared.fetchEpisodes(completion: { arrayOfFavorites in
          idForFacorite = arrayOfFavorites.count + 1
        })
        
        if let episodeName = sender.takenEpisode?.episodeName,
           let imageCharacter = sender.takenEpisode?.imageCharacter,
           let name = sender.takenEpisode?.character.name,
           let id = sender.takenEpisode?.character.id,
           let status = sender.takenEpisode?.character.status,
           let species = sender.takenEpisode?.character.species,
           let type = sender.takenEpisode?.character.type,
           let gender = sender.takenEpisode?.character.gender,
           let originName = sender.takenEpisode?.character.origin.name,
           let locationName = sender.takenEpisode?.character.location.name,
           let favoriteListID = idForFacorite,
           let episodeID = sender.episodeID
        {
          CoreDataManager.shared.createEpisode(
            episodeName: episodeName,
            imageCharacter: imageCharacter,
            isFavorite: true,
            name: name,
            charID: id,
            status: status,
            species: species,
            type: type,
            gender: gender,
            originName: originName,
            locationName: locationName,
            favoriteListID: favoriteListID,
            episodeID: episodeID
          )
        }
      } else {
        if let charId = sender.takenEpisode?.character.id {
          self.referenceToFavorite!.deleteFromFavorite(charID: charId)
        }
      }
      self.referenceToFavorite?.getResult()
      self.referenceToFavorite?.episodesCollectionView.reloadData()
    }
  }
}


class CustomTapGestureRecognizer: UITapGestureRecognizer {
  var takenEpisode: RequiredResult?
  var episodeID: Int?
  var indx: Int?
  var viewToAnimate: UIView?

}
