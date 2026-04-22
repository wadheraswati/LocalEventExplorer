//
//  EventDataRepositoryProtocol.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

protocol EventDataRepositoryProtocol {
    func fetchEvents() async throws -> [Event]
    func fetchBookmarkedEvents() async throws -> [Event]
    func update(_ event: Event)
}
