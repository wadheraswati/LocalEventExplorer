//
//  Event.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import Foundation

class Event: Codable, Identifiable {
    var id: Int
    var title: String
    var location: String
    var time: Date
    var imageURL: String
    var isBookmarked: Bool

    init(id: Int,
         title: String,
         location: String,
         time: Date,
         imageURL: String,
         isBookmarked: Bool = false) {
        self.id = id
        self.title = title
        self.location = location
        self.time = time
        self.imageURL = imageURL
        self.isBookmarked = isBookmarked
    }
}
