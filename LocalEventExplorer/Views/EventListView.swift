//
//  EventListView.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import SwiftUI

struct EventListView: View {
    @StateObject var viewModel = EventViewModel()
    
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
        }
    }
}

#Preview {
    EventListView()
}
