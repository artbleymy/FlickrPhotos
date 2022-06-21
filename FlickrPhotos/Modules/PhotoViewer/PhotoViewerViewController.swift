//
//  PhotoViewerViewController.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import UIKit

final class PhotoViewerViewController: UIViewController {
  private let viewModel: PhotoViewerViewModel

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  init(
    viewModel: PhotoViewerViewModel
  ) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
    self.title = viewModel.photo.title
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    showPhoto()
  }

  private func setupLayout() {
    view.backgroundColor = .systemBackground
    view.addSubview(imageView)

    let constraints = [
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ]

    NSLayoutConstraint.activate(constraints)
  }

  private func showPhoto() {
    viewModel.loadPhoto { [weak self] image in
      self?.imageView.image = image
    }
  }
}
