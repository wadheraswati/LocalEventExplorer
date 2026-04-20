//
//  EventServiceTests.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-20.
//

import XCTest
@testable import LocalEventExplorer

final class EventServiceTests: XCTestCase {
    @MainActor
    func testFetchEvents() async throws {
        // Given
        let eventDataRepo = EventDataRepository()
        let service = EventService(eventDataRepository: eventDataRepo)
        let expectation = XCTestExpectation(description: "Data loaded")
        var events = [Event]()
        
        // When
        Task {
            events = try await service.fetchEvents()
            expectation.fulfill()
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertFalse(events.isEmpty)
    }
}
