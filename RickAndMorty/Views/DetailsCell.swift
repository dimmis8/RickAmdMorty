//
//  DetailsCell.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 16.12.2023.
//

import UIKit

class DetailsCell: UITableViewCell {

  let headingLabel = UILabel()
  let statusLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupCell() {
    
    self.contentView.addSubview(headingLabel)
    headingLabel.translatesAutoresizingMaskIntoConstraints = false
    headingLabel.contentMode = .bottomLeft
    headingLabel.font = UIFont.boldSystemFont(ofSize: 15)
    
    NSLayoutConstraint.activate([
      headingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
      headingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      headingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      headingLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
    ])
    
    self.contentView.addSubview(statusLabel)
    statusLabel.translatesAutoresizingMaskIntoConstraints = false
    statusLabel.contentMode = .topLeft
    statusLabel.font = UIFont.systemFont(ofSize: 14)
    
    NSLayoutConstraint.activate([
      statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
      statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
      statusLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 45)
    ])
    
  }
}
