//
//  EventListView.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import SwiftUI

struct EventListView: View {
    @StateObject private var viewModel: EventViewModel
    
    init() {
        let service = EventService(eventDataRepository: EventDataRepository())
        _viewModel = StateObject(
            wrappedValue: EventViewModel(
                service: service,
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.events) { event in
                    NavigationLink {
                        EventDetailView(event: event, onBookmarkTap: {
                            viewModel.toggleBookmark(event)
                        })
                    } label: {
                        EventRowView(event: event, onBookmarkTap: {
                            viewModel.toggleBookmark(event)
                        })
                    }
                }
            }
        }.task {
            await viewModel.fetchEvents()
        }.onAppear {
            LocationManager().requestPermission()
            LocationManager().startUpdating()
        }
    }
}

#Preview {
    EventListView()
}
