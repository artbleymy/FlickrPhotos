//
//  ModulesFactory.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import UIKit

final class ModulesFactory {
  lazy var navigationController = makeNavigationController()
  
  private lazy var feedModule = makeFeedViewController()
  private lazy var imagesRepository = makeImagesRepository()
  private lazy var imagesCache = makeImagesCache()
  
  private func makeNavigationController() -> UIViewController {
    UINavigationController(rootViewController: feedModule)
  }
  
  private func makeFeedViewController() -> UIViewController {
    let viewModel = FeedViewModel()

    return FeedViewController(
      viewModel: viewModel,
      imagesRepository: imagesRepository
    )
  }
  
  private func makeImagesRepository() -> ImagesRepository {
    let configuration = URLSessionConfiguration.default
    configuration.urlCache = imagesCache
    configuration.httpMaximumConnectionsPerHost = 5
    
    let urlSession = URLSession(configuration: configuration)
    let networkService = NetworkService(urlSession: urlSession)
    
    return ImagesRepository(cache: imagesCache, networkService: networkService)
  }
  
  private func makeImagesCache() -> URLCache {
    URLCache(
      memoryCapacity: 50 * 1024 * 1024,
      diskCapacity: 100 * 1024 * 1024,
      diskPath: "images"
    )
  }
}

