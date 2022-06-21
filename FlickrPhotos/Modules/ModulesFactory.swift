//
//  ModulesFactory.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import UIKit

let MB = 1024

final class ModulesFactory {
  lazy var navigationController = makeNavigationController()
  
  private lazy var feedModule = makeFeedViewController()
  private lazy var imagesRepository = makeImagesRepository()
  private lazy var feedRepository = makeFeedRepository()
  private lazy var imagesCache = makeImagesCache()
  
  private func makeNavigationController() -> UINavigationController {
    UINavigationController(rootViewController: feedModule)
  }
  
  private func makeFeedViewController() -> UIViewController {
    
    let viewModel = FeedViewModel(feedRepository: feedRepository)

    let viewController = FeedViewController(
      viewModel: viewModel,
      imagesRepository: imagesRepository
    )
    
    viewController.openPhotoHandler = { photo in
      let photoViewerViewController = self.makePhotoViewerModule(with: photo)
      self.navigationController.pushViewController(photoViewerViewController, animated: true)
    }
    
    return viewController
  }
  
  private func makeFeedRepository() -> FeedRepository {
    let networkService = NetworkService(urlSession: URLSession.shared)
    return FeedRepository(networkService: networkService)
  }
  
  private func makeImagesRepository() -> ImagesRepository {
    let configuration = URLSessionConfiguration.default
    configuration.urlCache = imagesCache
    configuration.httpMaximumConnectionsPerHost = 5
    
    let urlSession = URLSession(configuration: configuration)
    let networkService = NetworkService(urlSession: urlSession)
    
    return ImagesRepository(cache: imagesCache, networkService: networkService)
  }
  
  private func makePhotoViewerModule(with photo: Photo) -> PhotoViewerViewController {
    let viewModel = PhotoViewerViewModel(photo: photo, imageRepository: imagesRepository)
    
    return PhotoViewerViewController(viewModel: viewModel)
  }
  
  private func makeImagesCache() -> URLCache {
    URLCache(
      memoryCapacity: 50 * MB,
      diskCapacity: 100 * MB,
      diskPath: "images"
    )
  }
}

