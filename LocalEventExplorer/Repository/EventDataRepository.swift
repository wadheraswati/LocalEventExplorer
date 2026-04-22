//
//  EventDataRepository.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//
import CoreData

// Entity → Model
extension Event {
    init(entity: EventModel) {
        self.init(
            id: entity.id ?? UUID(),
            title: entity.title ?? "",
            location: entity.location ?? "",
            time: entity.time ?? Date(),
            imageURL: entity.imageURL ?? "",
            isBookmarked: entity.isBookmarked,
            longitude: entity.longitude,
            latitude: entity.latitude
        )
    }
}

// Model → Entity
extension EventModel {
    func update(from event: Event) {
        self.id = event.id
        self.title = event.title
        self.location = event.location
        self.time = event.time
        self.imageURL = event.imageURL
        self.isBookmarked = event.isBookmarked
        self.latitude = event.latitude
        self.longitude = event.longitude
    }
}

class EventDataRepository: EventDataRepositoryProtocol {
    
    let dataManager = CoreDataManager.shared

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
    
    func fetchBookmarkedEvents() async throws -> [Event] {
        do {
            return try await NetworkManager.shared.request(
                endpoint: .getEvents,
                responseType: [Event].self
            )
        }
        catch {
            return try await dataManager.fetchBookmarkedEventsFromDB()
        }
    }
    
    private func fetchEventsFromLocal() async throws -> [Event] {
        do {
            let events = try await dataManager.fetchEventsFromDB()
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
            dataManager.saveEventsInDB(events)
            return events
        } catch {
            print(error)
        }
        return []
    }
   
    func update(_ event: Event) {
        dataManager.update(event)
    }
}
