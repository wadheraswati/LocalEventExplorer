//
//  EventViewModelTests.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-19.
//

import XCTest
import CoreData
@testable import LocalEventExplorer

@MainActor
final class EventViewModelTests: XCTestCase {
    
    func testFetchEvents() {
        // Given
        let vm = EventViewModel(
            repository: EventDataRepositoryMock())
        
        // When
        Task {
            await vm.fetchEvents()
        }
        
        // Then
        XCTAssertTrue(vm.events.isEmpty)
    }
    
    func testBookmarkedEvents() {
        // Given
        let vm = BookmarkedEventsViewModel(repository: EventDataRepositoryMock())
        
        // When
        Task {
            await vm.fetchEvents()
        }
        
        // Then
        XCTAssertTrue(vm.events.isEmpty)
    }
    
    func testToggleBookmark() async throws {
        // Given
        let vm = EventViewModel(
            repository: EventDataRepositoryMock())
        
        let expectation = XCTestExpectation(description: "Data loaded")

        Task {
            await vm.fetchEvents()
            expectation.fulfill()
        }
        
        // When
        await fulfillment(of: [expectation], timeout: 2.0)
        vm.toggleBookmark(vm.events[0])

        // Then
        XCTAssertTrue(vm.events.first?.isBookmarked == true)
    }
}
