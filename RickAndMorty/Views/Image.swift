//
//  Launch.swift
//  RickAndMorty
//
//  Created by Dmitry Logvinov on 12.12.2023.
//

import UIKit


class Image: UIImageView {
  
  func getViewLogo() -> UIView {
    let logoImage = UIImage(named: "Logo")
    let view = UIImageView(image: logoImage)
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
  
  func getViewLoading() -> UIView{
    let loadingImage = UIImage(named: "Loading")
    let view = UIImageView(image: loadingImage)
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
}
