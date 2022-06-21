//
//  ImageLoadingError.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import Foundation

enum ImageLoadingError: Error, LocalizedError {
  case corruptedImage(url: URL)
  case networkError(NetworkError)
  
  var errorDescription: String? {
    switch self {
    case let .corruptedImage(url):
      return "Image on url \(url) corrupted"
    case let .networkError(error):
      return "Network error: \(error.localizedDescription)"
    }
  }
}
