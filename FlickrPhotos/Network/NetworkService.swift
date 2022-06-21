//
//  NetworkService.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import Foundation

struct NetworkService {
  private let urlSession: URLSession
  
  init(urlSession: URLSession) {
    self.urlSession = urlSession
  }
  
  func request(
    _ url: URL,
    completion: @escaping (Result<Data, NetworkError>) -> Void
  ) {
    urlSession.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(.networkError(error)))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        completion(.failure(.httpResponseError))
        return
      }
      
      let validStatusCodes = 200..<400
      guard validStatusCodes.contains(httpResponse.statusCode) else {
        completion(.failure(.unacceptableResponseCode(httpResponse.statusCode)))
        return
      }
      
      guard let data = data else {
        completion(.failure(.emptyDataError))
        return
      }
      
      completion(.success(data))
      
    }.resume()
  }
}
