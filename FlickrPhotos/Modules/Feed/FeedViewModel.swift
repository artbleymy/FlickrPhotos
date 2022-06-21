//
//  FeedViewModel.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import Foundation

final class FeedViewModel {
  private enum State {
    case initial
    case loading
    case loaded
  }

  var items = FeedMock.default.photos.photo

  private var state: State = .initial
  
  init() { }
  
  func loadFeed(completion: @escaping () -> Void) {
    guard state != .loading else { return }
    state = .loading
    // TODO: add feed loading
    completion()
    state = .loaded
  }
}
