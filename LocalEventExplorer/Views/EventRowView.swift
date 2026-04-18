//
//  EventRowView.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import SwiftUI


struct EventRowView: View {
    
    var event: Event
    let onBookmarkTap: () -> Void

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: event.imageURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(event.title)
                HStack {
                    Image(systemName: "location")
                    Text(event.location)
                }
                HStack {
                    Image(systemName: "calendar")
                    Text(event.time.formatted(date: .abbreviated, time: .shortened))
                }
            }
            
            Spacer()
            
            Button {
                onBookmarkTap()
            } label: {
                Image(systemName: event.isBookmarked ? "bookmark.fill" : "bookmark")
            }.buttonStyle(.plain)
        }
    }
}

#Preview {
    var event = Event(id: UUID(),
                      title: "Baisakhi Celebration",
                      location: "City Hall",
                      time: Date(timeIntervalSinceNow: 1500),
                      imageURL: "https://picsum.photos/300/300?random=6",
                      isBookmarked: false)
    EventRowView(event: event, onBookmarkTap: {})
}
