//
//  EventDataRepositoryProtocol.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

protocol EventDataRepositoryProtocol {
    func fetchEventsFromDB() async throws -> [Event]
    func saveEventsInDB(_ events: [Event])
    func update(_ event: Event)
}
