//
//  Event.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import Foundation

struct Event: Codable, Identifiable {
    var id: UUID
    var title: String
    var location: String
    var time: Date
    var imageURL: String
    var isBookmarked: Bool
    var latitude: Double
    var longitude: Double

    init(id: UUID,
         title: String,
         location: String,
         time: Date,
         imageURL: String,
         isBookmarked: Bool = false,
         longitude: Double,
         latitude: Double) {
        self.id = id
        self.title = title
        self.location = location
        self.time = time
        self.imageURL = imageURL
        self.isBookmarked = isBookmarked
        self.longitude = longitude
        self.latitude = latitude
    }
}
