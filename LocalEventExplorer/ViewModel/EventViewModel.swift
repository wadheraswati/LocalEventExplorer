//
//  EventViewModel.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import Combine

class EventViewModel: ObservableObject {
    @Published var events = [Event]()
    
    private let service = EventService()

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
