//
//  EventViewModel.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import Combine

protocol EventProtocol {
    func fetchEvents() async throws -> [Event]
    func update(_ event: Event)
}

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    private let service: EventProtocol
    
    init(service: EventProtocol) {
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
            if currentEvent.id == event.id {
                currentEvent.isBookmarked.toggle()
                service.update(currentEvent)
            }
            return currentEvent
        }
    }
}
