//
//  EventDataRepositoryMock.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-19.
//

import XCTest
@testable import LocalEventExplorer

class EventDataRepositoryMock: EventDataRepositoryProtocol {
    
    var dbUpdated: Bool = false
    
    func fetchEvents() async throws -> [Event] {
        return [Event.mockEvent]
    }
    
    func fetchBookmarkedEvents() async throws -> [Event] {
        let events = [Event.mockEvent]
        let bookmarkedEvents = events.filter({$0.isBookmarked == true})
        return bookmarkedEvents
    }
    
    func update(_ event: Event) {
        dbUpdated = true
    }
}

extension Event {
    static var mockEvent: Event {
        Event(
            id: UUID(),
            title: "Test",
            location: "Toronto",
            time: Date(),
            imageURL: "",
            isBookmarked: false,
            longitude: 74.98,
            latitude: -67.89
        )
    }
}
