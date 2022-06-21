//
//  FeedMock.swift
//  FlickrPhotos
//
//  Created by Stanislav on 21.06.2022.
//

import Foundation

enum FeedMock {
  static let `default` = Feed(
    photos: PhotosList(
      page: 1,
      pages: 2,
      photo: [
        Photo(
          title: "Hike into the Sunset",
          imageURL: URL(string: "https://live.staticflickr.com/65535/52155275091_d16b1662de.jpg")!,
          height: 334,
          width: 500
        ),
        Photo(
          title: "Treasured moments",
          imageURL: URL(string: "https://live.staticflickr.com/65535/52153896217_16a3e23b95.jpg")!,
          height: 281,
          width: 500
        ),
        Photo(
          title: "Huppe fasciée",
          imageURL: URL(string: "https://live.staticflickr.com/65535/52153279046_1a7b77b784.jpg")!,
          height: 367,
          width: 500
        ),
        Photo(
          title: "Distant Worlds",
          imageURL: URL(string: "https://live.staticflickr.com/65535/52154296863_4d6f128791.jpg")!,
          height: 334,
          width: 500
        ),
        Photo(
          title: "glicinia",
          imageURL: URL(string: "https://live.staticflickr.com/65535/52152674132_291d4b4666.jpg")!,
          height: 484,
          width: 500
        ),
        Photo(
          title: "Spritz en el jardín",
          imageURL: URL(string: "https://live.staticflickr.com/65535/52153921335_1e31506418.jpg")!,
          height: 338,
          width: 500
        ),
        Photo(
          title: "The green lake",
          imageURL: URL(string: "https://live.staticflickr.com/65535/52154473116_35b9d28de3.jpg")!,
          height: 366,
          width: 500
        ),
      ])
  )

  static let more = Feed(
    photos: PhotosList(
      page: 2,
      pages: 2,
      photo: [
        Photo(
          title: "Starlink Mission",
          imageURL: URL(string: "https://live.staticflickr.com/65535/52154049938_42897d576e.jpg")!,
          height: 500,
          width: 333
        ),
        Photo(
          title: "Schachbrett auf Luzerne",
          imageURL: URL(string: "https://live.staticflickr.com/65535/52153590664_2a4d1b7d1b.jpg")!,
          height: 333,
          width: 500
        )
      ])
  )
}
