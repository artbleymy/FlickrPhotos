//
//  ViewController.swift
//  FlickrPhotos
//
//  Created by Stanislav on 20.06.2022.
//

import UIKit

final class FeedViewController: UIViewController {
  let items = FeedMock.default.photos.photo
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.reuseId)
    collectionView.dataSource = self
    collectionView.delegate = self
    return collectionView
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Flickr's interestingness"
    setupLayout()    
  }
  
  func setupLayout() {
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)

    let constraints = [
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
  }
}

extension FeedViewController: UICollectionViewDelegate {}

extension FeedViewController: UICollectionViewDataSource {
  func collectionView(
    _: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    items.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.reuseId, for: indexPath) as? FeedCell
    else {
      fatalError("Dequeue feed cell error")
    }
    cell.setupCell(with: items[indexPath.item].imageURL)
    return cell
  }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    CGSize(width: view.bounds.width, height: 200)
  }
}
