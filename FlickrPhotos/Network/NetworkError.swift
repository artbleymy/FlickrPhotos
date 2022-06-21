//
//  NetworkError.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import Foundation

enum NetworkError: Error, LocalizedError {
  case unacceptableResponseCode(Int)
  case networkError(Error)
  case emptyDataError
  case httpResponseError

  var errorDescription: String? {
    switch self {
    case .unacceptableResponseCode(let code):
      return "Http error with code \(code)"
    case .networkError(let error):
      return "Network error: \(error)"
    case .emptyDataError:
      return "Empty data"
    case .httpResponseError:
      return "Empty http response"
    }
  }
}
