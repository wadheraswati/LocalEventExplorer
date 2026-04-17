//
//  EventService.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import Foundation

class EventService {
    func fetchEvents() async throws -> [Event] {
        do {
            return try await NetworkManager.shared.request(
                endpoint: .getEvents,
                responseType: [Event].self
            )
        }
        catch {
            return try await loadEvents()
        }
    }
    
    func loadEvents() async throws -> [Event] {
        
        guard let url = Bundle.main.url(forResource: "Events", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try decoder.decode([Event].self, from: data)
    }
}
