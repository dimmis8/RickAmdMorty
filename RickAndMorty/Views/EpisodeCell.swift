//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 13.12.2023.
//

import UIKit

class EpisodeCell: UICollectionViewCell {
    
  let imageView = UIImageView()
  let labelNameView = UILabel()
  let labelSpecies = UILabel()
  let labelView = UILabel()
  let playIcon = UIImageView(image: UIImage(named: "Play"))
  var heartIcon = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    
    self.contentView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    
    //обрезание изображений по краям ячейки
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 10
    
    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: 300),
      imageView.widthAnchor.constraint(equalToConstant: 400),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -110)
    ])
    
    self.contentView.addSubview(labelNameView)
    labelNameView.translatesAutoresizingMaskIntoConstraints = false
    labelNameView.contentMode = .bottomLeft
    labelNameView.font = UIFont.boldSystemFont(ofSize: 17)
    labelNameView.backgroundColor = .white
    
    NSLayoutConstraint.activate([
      labelNameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      labelNameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      labelNameView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
      labelNameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -75)
    ])
    
    self.contentView.addSubview(labelSpecies)
    labelSpecies.translatesAutoresizingMaskIntoConstraints = false
    labelSpecies.contentMode = .bottomLeft
    labelSpecies.font = UIFont.systemFont(ofSize: 12)
    labelSpecies.textColor = .darkGray
    
    NSLayoutConstraint.activate([
      labelSpecies.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
      labelSpecies.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      labelSpecies.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
      labelSpecies.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -65)
    ])
    
    self.contentView.addSubview(playIcon)
    playIcon.translatesAutoresizingMaskIntoConstraints = false
    playIcon.contentMode = .scaleAspectFit
        
    NSLayoutConstraint.activate([
      playIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 17),
      playIcon.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 42),
      playIcon.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -42),
      playIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17)
    ])
    
    self.contentView.addSubview(labelView)
    labelView.translatesAutoresizingMaskIntoConstraints = false
    labelView.contentMode = .bottomLeft
    labelView.font = UIFont.systemFont(ofSize: 14)
    
    NSLayoutConstraint.activate([
      labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
      labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
      labelView.topAnchor.constraint(equalTo: labelSpecies.bottomAnchor, constant: 20),
      labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
    ])
    
    self.contentView.addSubview(heartIcon)
    heartIcon.translatesAutoresizingMaskIntoConstraints = false
    heartIcon.contentMode = .scaleAspectFit
        
    NSLayoutConstraint.activate([
      heartIcon.leadingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -44),
      heartIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      heartIcon.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -46),
      heartIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
    ])
    
    //добавляем тень ячейке
    self.layer.cornerRadius = 10
    self.layer.shadowColor = UIColor.lightGray.cgColor
    self.layer.shadowRadius = 5
    self.layer.shadowOpacity = 1
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.backgroundColor = .white
    self.layer.masksToBounds = false
  }
}

