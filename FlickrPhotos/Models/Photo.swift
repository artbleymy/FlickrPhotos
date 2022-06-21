//
//  Photo.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import Foundation

struct Photo: Codable {
  let title: String
  let imageURL: URL
  let height: Int
  let width: Int
  
  var aspectRatio: Double {
    Double(height) / Double(width)
  }
  
  private enum CodingKeys: String, CodingKey {
    case title
    case imageURL = "url_m"
    case height = "height_m"
    case width = "width_m"
  }
}
