//
//  FeedCell.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import UIKit

final class FeedCell: UICollectionViewCell {
  static let reuseId = "FeedCell"
  
  private lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.numberOfLines = 0
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupCell(with imageURL: URL) {
    label.text = imageURL.absoluteString
  }

  private func setupLayout() {
    addSubview(label)
    
    let constraints = [
      label.topAnchor.constraint(equalTo: topAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor),
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}
