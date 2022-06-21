//
//  FeedLoadingError.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import Foundation

enum FeedLoadingError: Error, LocalizedError {
  case parsingError(Error)
  case networkError(NetworkError)

  var errorDescription: String? {
    switch self {
    case let .parsingError(error):
      return "JSON parsing error: \(error)"
    case let .networkError(error):
      return "Network error: \(error.localizedDescription)"
    }
  }
}
