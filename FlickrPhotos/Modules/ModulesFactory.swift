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
  
  private func makeNavigationController() -> UIViewController {
    UINavigationController(rootViewController: feedModule)
  }
  
  private func makeFeedViewController() -> UIViewController {
    let viewModel = FeedViewModel()
    return FeedViewController(viewModel: viewModel)
  }
}

