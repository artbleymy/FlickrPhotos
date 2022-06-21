//
//  PhotosList.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

struct PhotosList: Codable {
  let page: Int
  let pages: Int
  let photo: [Photo]
}
