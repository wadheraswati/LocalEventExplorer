//
//  EventDataManager.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//
import CoreData

// Entity → Model
extension Event {
    convenience init(entity: EventModel) {
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

class EventDataManager {
    static func fetchEventsFromDB() async throws -> [Event] {
        let context = CoreDataManager.shared.context
        
        let request: NSFetchRequest<EventModel> = EventModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
        
        do {
            let entities = try context.fetch(request)
            return entities.map { Event(entity: $0) }
        } catch {
            print("Fetch error: \(error)")
        }
        return []
    }
    
    static func saveEventsInDB(_ events: [Event]) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = EventModel.fetchRequest()

        for event in events {
            let entity = EventModel(context: context)
            entity.update(from: event)
        }
        CoreDataManager.shared.save()
    }
    
    static func update(_ event: Event) {
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<EventModel> = EventModel.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", event.id as CVarArg)
        
        do {
            if let entity = try context.fetch(request).first {
                entity.isBookmarked = event.isBookmarked
                CoreDataManager.shared.save()
            }
        } catch {
            print("Toggle error: \(error)")
        }
    }
}
