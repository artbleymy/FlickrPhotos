//
//  PhotoViewerViewModel.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import UIKit

final class PhotoViewerViewModel {
  let photo: Photo
  
  private let imageRepository: ImagesRepository
  
  init(
    photo: Photo,
    imageRepository: ImagesRepository
  ) {
    self.imageRepository = imageRepository
    self.photo = photo
  }
  
  func loadPhoto(completion: @escaping (UIImage) -> Void) {
    imageRepository.loadImage(for: photo.imageURL) { result in
      switch result {
      case let .success(image):
        completion(image)
      case let .failure(error):
        print("[Error]: \(error.localizedDescription)")
      }
    }
  }
}
