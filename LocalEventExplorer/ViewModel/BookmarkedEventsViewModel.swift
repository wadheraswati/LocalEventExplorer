//
//  BookmarkedEventsViewModel.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-22.
//

import Combine

class BookmarkedEventsViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    private let repository: EventDataRepositoryProtocol
    
    init(repository: EventDataRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchEvents() async {
        do {
            events = try await repository.fetchBookmarkedEvents()
        }
        catch {
            print("API Error: \(error)")
        }
    }
    
    func toggleBookmark(_ event: Event) {
        events = events.map { currentEvent in
            var updatedEvent = currentEvent
            if updatedEvent.id == event.id {
                updatedEvent.isBookmarked.toggle()
                repository.update(updatedEvent)
            }
            return updatedEvent
        }
    }
}
