//
//  EventViewModel.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import Combine

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    private let service: EventServiceProtocol
    
    init(service: EventServiceProtocol) {
        self.service = service
    }
    
    func fetchEvents() async {
        do {
            events = try await service.fetchEvents()
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
                service.update(updatedEvent)
            }
            return updatedEvent
        }
    }
}
