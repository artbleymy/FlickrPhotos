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

  var items: [Photo] = []
  
  private let feedRepository: FeedRepository
  
  private var currentPage = 1
  private var numberOfPages = Int.max
  private var state: State = .initial
  
  init(feedRepository: FeedRepository) {
    self.feedRepository = feedRepository
  }
  
  func loadFeed(completion: @escaping () -> Void) {
    guard state != .loading else { return }
    guard currentPage <= numberOfPages else { return }
    
    state = .loading
    // TODO: add feed loading
    feedRepository.loadFeed(page: currentPage) { [weak self] result in
      guard let self = self else { return }

      switch result {
      case let .failure(error):
        print("[Error]: \(error.localizedDescription)")
        
      case let .success(feed):
        self.items.append(contentsOf: feed.photos.photo)
        self.numberOfPages = feed.photos.pages
        self.currentPage += 1
        completion()
      }
      self.state = .loaded
    }
  }
}
