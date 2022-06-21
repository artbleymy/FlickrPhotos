//
//  ImagesRepository.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import UIKit

struct ImagesRepository {
  typealias ImageLoadingResult = Result<UIImage, ImageLoadingError>

  private let cache: URLCache
  private let networkService: NetworkService

  init(
    cache: URLCache,
    networkService: NetworkService
  ) {
    self.cache = cache
    self.networkService = networkService
  }

  func loadImage(
    for url: URL,
    completion: @escaping (ImageLoadingResult) -> Void
  ) {
    let request = URLRequest(url: url)
    DispatchQueue.global(qos: .userInitiated).async {
      if let data = cache.cachedResponse(for: request)?.data,
         let image = UIImage(data: data) {
        DispatchQueue.main.async {
          completion(.success(image))
        }
        return
      } else {
        networkService.request(url) { result in
          switch result {
          case let .success(data):
            guard let image = UIImage(data: data) else {
              DispatchQueue.main.async {
                completion(.failure(.corruptedImage(url: url)))
              }
              return
            }
            DispatchQueue.main.async {
              completion(.success(image))
            }
          case let .failure(error):
            DispatchQueue.main.async {
              completion(.failure(.networkError(error)))
            }
          }
        }
      }
    }
  }
}
