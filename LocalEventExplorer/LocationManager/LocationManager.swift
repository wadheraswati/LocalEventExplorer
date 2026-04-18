//
//  LocationManager.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-17.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func startUpdating() {
        manager.startUpdatingLocation()
    }
    
    // MARK: - Delegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        if authorizationStatus == .authorizedWhenInUse ||
            authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first
    }
}
