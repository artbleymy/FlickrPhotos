//
//  ViewController.swift
//  FlickrPhotos
//
//  Created by Stanislav on 20.06.2022.
//

import UIKit

final class FeedViewController: UIViewController {
  
  private let viewModel: FeedViewModel
  private let imagesRepository: ImagesRepository

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
  
  init(
    viewModel: FeedViewModel,
    imagesRepository: ImagesRepository
  ) {
    self.viewModel = viewModel
    self.imagesRepository = imagesRepository
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Flickr's interestingness"
    setupLayout()
    loadFeed()
  }
  
  private func setupLayout() {
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
  
  private func loadFeed() {
    viewModel.loadFeed() { [weak self] in
      self?.collectionView.reloadData()
    }
  }
}

extension FeedViewController: UICollectionViewDelegate {
  
  func collectionView(
    _ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    if indexPath.row >= viewModel.items.count - 5 {
      viewModel.loadFeed() {
        collectionView.reloadSections(IndexSet(integer: 0))
      }
    }
  }
}

extension FeedViewController: UICollectionViewDataSource {
  func collectionView(
    _: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    viewModel.items.count
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
    cell.setupCell(
      with: viewModel.items[indexPath.item],
      repository: imagesRepository
    )
    return cell
  }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let aspectRatio = viewModel.items[indexPath.item].aspectRatio
    let width = view.bounds.width
    let height = width * aspectRatio
    return CGSize(width: width, height: height)
  }
}
