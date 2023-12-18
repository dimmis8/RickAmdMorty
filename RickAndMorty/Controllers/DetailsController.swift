//
//  DetailsController.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 16.12.2023.
//

import UIKit
import AVFoundation

class DetailsController: UIViewController {
  //информация о персонаже
  var episode: RequiredResult?
  //инициализируем тейбл вью
  var detailsTableView = UITableView()
  let identifire = "MyCell"
  
  
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white
      
      //настройка тейбл вью
      setupDetailsTableView()
      //добавляем изображение в нав бар
      addImageToNavBar()
    }
  
  // установка тейбл вью
  func setupDetailsTableView() {
    self.detailsTableView = UITableView(frame: view.bounds, style: .plain)
    detailsTableView.register(DetailsCell.self, forCellReuseIdentifier: "\(DetailsCell.self)")
    self.detailsTableView.delegate = self
    self.detailsTableView.dataSource = self
    self.detailsTableView.rowHeight = UITableView.automaticDimension
    self.detailsTableView.estimatedRowHeight = 80
    
    view.addSubview(detailsTableView)
  }
  
  // функция для размещения изображения в навигационном баре
  func addImageToNavBar() {
    let imageNav = UIImage(named: "IconNav")
    //получаем размеры бара
    let widthNavBar = navigationController?.navigationBar.frame.width
    let heightNavBar = 50
    //создаем контейнер
    let logoContainer = UIView(frame: CGRect(x: Int(0.6 * widthNavBar!), y: 0, width: Int(0.4 * widthNavBar!), height: Int(heightNavBar)))
    let imageView = UIImageView(frame: CGRect(x: Int(0.55 * widthNavBar!), y: 0, width: Int(0.1 * widthNavBar!), height: Int(heightNavBar)))
    imageView.image = imageNav
    imageView.contentMode = .scaleAspectFit
    logoContainer.addSubview(imageView)
    navigationItem.titleView = logoContainer
    navigationController?.navigationItem.backBarButtonItem?.title = "Go Back"
  }
  
}

//расширение тейбл вью для передачи информации в ячейки
extension DetailsController: UITableViewDataSource {
  //задание количества ячеек во вью
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  //наполение ячеек
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: "\(DetailsCell.self)", for: indexPath) as? DetailsCell else {
      return UITableViewCell()
    }
    let infoForCell = pasteInformation(forNumberCell: indexPath.row)
    cell.backgroundColor = .white
    cell.headingLabel.text = infoForCell.heading
    cell.statusLabel.text = infoForCell.status
    return cell
  }
  //функция выбора информации для каждой ячейки
  func pasteInformation(forNumberCell: Int) -> (heading: String, status: String) {
    switch forNumberCell {
    case 0:
      return ("Gender", episode!.character.gender)
    case 1:
      return ("Status", episode!.character.status)
    case 2:
      return ("Specie", episode!.character.species)
    case 3:
      return ("Origin", episode!.character.origin.name)
    case 4:
      return ("Type", episode!.character.type)
    case 5:
      return ("Location", episode!.character.location.name)
    default:
      return ("", "")
    }
  }
  
  //функция наполнения хедера
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 230))
    let label = UILabel()
    let image = UIImageView()
    let labelInformation = UILabel()
    let camera = UIButton()
    headerView.backgroundColor = .white
    
    image.frame = CGRect.init(x: headerView.frame.width/3, y: 0, width: headerView.frame.width/3, height: headerView.frame.width/3)
    image.image = UIImage(data: episode!.imageCharacter)
    image.clipsToBounds = true
    image.layer.cornerRadius = image.frame.width / 2
    headerView.addSubview(image)
    
    label.frame = CGRect.init(x: 0, y: image.frame.height + 15, width: headerView.frame.width, height: 30)
    label.text = episode?.character.name
    label.textAlignment = .center
    label.font = .boldSystemFont(ofSize: 30)
    headerView.addSubview(label)
    
    labelInformation.frame = CGRect.init(x: 15, y: image.frame.height + 65, width: headerView.frame.width - 10, height: 20)
    labelInformation.text = "Information:"
    labelInformation.font = .systemFont(ofSize: 20)
    labelInformation.textColor = .lightGray
    headerView.addSubview(labelInformation)
    
    camera.frame = CGRect.init(x: 2 * headerView.frame.width / 3 + 10, y: headerView.frame.width/6 - 10, width: 20, height: 20)
    camera.setImage(UIImage(named: "camera"), for: .normal)
    camera.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    headerView.addSubview(camera)
    
    
    return headerView
  }
  
  @objc func buttonTapped() {
    let alertController = UIAlertController(title: "Загрузите изображение", message: nil,preferredStyle: .actionSheet)
    let actionClose = UIAlertAction(title: "Закрыть", style: .cancel)
    let actionCamera = UIAlertAction(title: "Камера", style: .default) { (action) in
//      let capture = AVCaptureSession()
//      AVCaptureDevice.requestAccess(for: .video) { granted in
//        if granted{}
//      }
    }
    let actionGalerry = UIAlertAction(title: "Галерея", style: .default) { (action) in
//      let capture = AVCaptureSession()
//      AVCaptureDevice.requestAccess(for: .video) { granted in
//        if granted{}
//      }
    }
  
    alertController.addAction(actionCamera)
    alertController.addAction(actionClose)
    alertController.addAction(actionGalerry)
    self.present(alertController, animated: true)
  }

}

extension DetailsController: UITableViewDelegate {
  
  //высота ячейки
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
  }
  //высота хедера
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    230
  }
   
}
