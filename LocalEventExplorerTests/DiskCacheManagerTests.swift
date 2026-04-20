//
//  DiskCacheManagerTests.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-19.
//

import XCTest
@testable import LocalEventExplorer

final class DiskCacheManagerTests: XCTestCase {
    
    func testDiskCacheLoadImage() {
        
        let key = "test-image"
        let image = UIImage(systemName: "star")!
        
        // Save with short TTL (1 second)
        DiskCacheManager.shared.save(image, forKey: key)
        
        // Immediately available
        let cached = DiskCacheManager.shared.load(forKey: key)
        XCTAssertNotNil(cached)
    }
}
