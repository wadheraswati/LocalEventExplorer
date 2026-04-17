//
//  API.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//
import Foundation

enum APIEndpoint {
    case getEvents
    case getEventDetails(id: String)
}

extension APIEndpoint {
    var baseURL: String {
        return "https://api.youreventsapp.com"
    }
    
    var path: String {
        switch self {
        case .getEvents:
            return "/events"
        case .getEventDetails(let id):
            return "/event/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .getEvents, .getEventDetails:
            return "GET"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
}
