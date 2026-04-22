//
//  BookmarkedEventsView.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-22.
//

import SwiftUI

struct BookmarkedEventsView: View {
    @StateObject var viewModel = BookmarkedEventsViewModel(repository: EventDataRepository())
    
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
            .navigationTitle("Bookmarked Events")
        }.task {
            await viewModel.fetchEvents()
        }
    }
}
