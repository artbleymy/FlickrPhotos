//
//  FeedCell.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import UIKit

final class FeedCell: UICollectionViewCell {
  static let reuseId = "FeedCell"
  
  private var imageURL: URL?
  
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupCell(with photo: Photo, repository: ImagesRepository) {
    imageView.image = nil
    imageURL = photo.imageURL

    repository.loadImage(for: photo.imageURL) { [weak self] result in
      switch result {
      case let .success(image):
        if self?.imageURL == photo.imageURL {
          self?.imageView.image = image
        }
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }

  private func setupLayout() {
    addSubview(imageView)
    
    let constraints = [
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}
