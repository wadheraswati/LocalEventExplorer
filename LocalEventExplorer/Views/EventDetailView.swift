//
//  EventDetailView.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import SwiftUI
import CoreLocation
import MapKit

struct EventDetailView: View {
    
    var event: Event
    let onBookmarkTap: () -> Void
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        ScrollView {
            
            // MARK: - Hero Image with Bookmark Overlay
            ZStack(alignment: .bottomTrailing) {
                
                CachedImageView(urlString: event.imageURL)
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
                    Text("\(event.location) - \(distance)")
                }
                .foregroundColor(.secondary)
                .onTapGesture {
                    openMaps()
                }
                
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
    
    var distance: String {
        guard let user = locationManager.userLocation else { return "--" }
        
        let eventLocation = CLLocation(latitude: event.latitude,
                                       longitude: event.longitude)
        
        let meters = user.distance(from: eventLocation)
        
        let km = meters / 1000
        return String(format: "%.1f km away", km)
    }
    
    func openMaps() {
        let mapItem = MKMapItem(location: CLLocation(latitude: event.latitude, longitude: event.longitude), address: MKAddress(fullAddress: event.location, shortAddress: nil))
        mapItem.name = event.title
        
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

#Preview {
    var event = Event(id: UUID(),
                      title: "Baisakhi Celebration",
                      location: "City Hall",
                      time: Date(timeIntervalSinceNow: 1500),
                      imageURL: "https://picsum.photos/300/300?random=6",
                      isBookmarked: false,
                      longitude: -79.4637,
                      latitude: 43.6465)
    EventDetailView(event: event, onBookmarkTap: {})
}
