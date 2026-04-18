//
//  EventServiceProtocol.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

protocol EventServiceProtocol {
    func fetchEvents() async throws -> [Event]
    func update(_ event: Event)
}
