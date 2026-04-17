//
//  EventDetailView.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import SwiftUI

struct EventDetailView: View {
    
    var event: Event
    let onBookmarkTap: () -> Void

    var body: some View {
        ScrollView {
            
            // MARK: - Hero Image with Bookmark Overlay
            ZStack(alignment: .bottomTrailing) {
                
                AsyncImage(url: URL(string: event.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 280)
                .clipped()
                
                Button {
                    onBookmarkTap()
                } label: {
                    Image(systemName: event.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.white)
                        .padding()
                        .background(.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .padding()
            }
            
            // MARK: - Event Details
            VStack(alignment: .leading, spacing: 16) {
                
                Text(event.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Image(systemName: "location")
                    Text(event.location)
                }
                .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "calendar")
                    Text(event.time.formatted(date: .abbreviated, time: .shortened))
                }
                .foregroundColor(.secondary)
                
                Divider()
                
                // Description (mock for now)
                VStack(alignment: .leading) {
                    Text("About Event")
                        .font(.headline)
                    Text("""
                Join us for an exciting event filled with great experiences, networking opportunities, and entertainment. Perfect for friends, families, and professionals alike.
                """)
                    .font(.body)
                }
                
            }
            .padding()
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    var event = Event(id: 1,
                      title: "Baisakhi Celebration",
                      location: "City Hall",
                      time: Date(timeIntervalSinceNow: 1500),
                      imageURL: "https://picsum.photos/300/300?random=6",
                      isBookmarked: false)
    EventDetailView(event: event, onBookmarkTap: {})
}
