//
//  CoreDataManager.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EventModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    func fetchEventsFromDB() async throws -> [Event] {
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
    
    func fetchBookmarkedEventsFromDB() async throws -> [Event] {
        let context = CoreDataManager.shared.context
        
        let request: NSFetchRequest<EventModel> = EventModel.fetchRequest()
        request.predicate = NSPredicate(
            format: "isBookmarked == true"
        )
        
        do {
            let entities = try context.fetch(request)
            return entities.map { Event(entity: $0) }
        } catch {
            print("Fetch error: \(error)")
        }
        return []
    }
    
    func saveEventsInDB(_ events: [Event]) {
        let context = CoreDataManager.shared.context

        for event in events {
            let entity = EventModel(context: context)
            entity.update(from: event)
        }
        CoreDataManager.shared.save()
    }
    
    func update(_ event: Event) {
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
