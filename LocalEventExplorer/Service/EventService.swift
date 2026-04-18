//
//  EventService.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import Foundation
import CoreData

class EventService: EventServiceProtocol {
    
    let eventDataRepository: EventDataRepositoryProtocol
    
    init(eventDataRepository: EventDataRepositoryProtocol) {
        self.eventDataRepository = eventDataRepository
    }

    func fetchEvents() async throws -> [Event] {
        do {
            return try await NetworkManager.shared.request(
                endpoint: .getEvents,
                responseType: [Event].self
            )
        }
        catch {
            return try await fetchEventsFromLocal()
        }
    }
    
    private func fetchEventsFromLocal() async throws -> [Event] {
        do {
            let events = try await eventDataRepository.fetchEventsFromDB()
            guard !events.isEmpty else {
                return try await loadEventsFromLocalFile()
            }
            return events
        } catch {
            return try await loadEventsFromLocalFile()
        }
    }
    
    private func loadEventsFromLocalFile() async throws -> [Event] {
        guard let url = Bundle.main.url(forResource: "Events", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let events = try decoder.decode([Event].self, from: data)
            eventDataRepository.saveEventsInDB(events)
            return events
        } catch {
            print(error)
        }
        return []
    }
    
    func update(_ event: Event) {
        eventDataRepository.update(event)
    }
    
    
}
