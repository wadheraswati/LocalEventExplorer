//
//  MockEventService.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-19.
//

import XCTest
@testable import LocalEventExplorer

class MockEventService: EventServiceProtocol {
    
    var dbUpdated: Bool = false
    let eventDataRepository: EventDataRepositoryProtocol

    init(eventDataRepository: EventDataRepositoryProtocol) {
        self.eventDataRepository = eventDataRepository
    }
    
    func update(_ event: Event) {
        dbUpdated = true
    }
    
    func fetchEvents() async throws -> [Event] {
        return [Event.mockEvent]
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
