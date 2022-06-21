//
//  FeedRepository.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import Foundation

struct FeedRepository {
  private static let endpoint = "https://api.flickr.com/services/rest"
  
  private let networkService: NetworkService

  init(networkService: NetworkService) {
    self.networkService = networkService
  }

  func loadFeed(
    page: Int,
    completion: @escaping (Result<Feed, FeedLoadingError>) -> Void
  ) {
    let queryParams = [
      "method": "flickr.interestingness.getList",
      "api_key": "f7d8ca3dcae34cca78ca8a7a76181859",
      "per_page": "50",
      "format": "json",
      "nojsoncallback": "true",
      "extras": "url_m",
      "page": "\(page)"
    ].map { URLQueryItem(name: $0, value: $1) }

    var urlComponents = URLComponents(string: Self.endpoint)
    urlComponents?.queryItems = queryParams
    
    guard let url = urlComponents?.url else { return }

    networkService.request(url) { result in
      switch result {
      case let .success(data):
        do {
          let feed = try JSONDecoder().decode(Feed.self, from: data)
          DispatchQueue.main.async {
            completion(.success(feed))
          }
        } catch {
          DispatchQueue.main.async {
            completion(.failure(.parsingError(error)))
          }
        }
      case let.failure(error):
        DispatchQueue.main.async {
          completion(.failure(.networkError(error)))
        }
      }
    }
  }
}
