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
        _viewModel = StateObject(
            wrappedValue: EventViewModel(
                repository: EventDataRepository()
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
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        BookmarkedEventsView()
                    } label: {
                        Image(systemName: "bookmark.fill")
                    }
                    .buttonBorderShape(.capsule)
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
