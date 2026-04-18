//
//  ImageLoader.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-18.
//

import SwiftUI
import Combine

@MainActor
final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    func load(from urlString: String) async {
        
        // 1️⃣ Memory cache
        if let cached = ImageCache.shared.get(forKey: urlString) {
            self.image = cached
            return
        }
        
        // 2️⃣ Disk cache
        if let diskImage = DiskCacheManager.shared.load(forKey: urlString) {
            ImageCache.shared.set(diskImage, forKey: urlString)
            self.image = diskImage
            return
        }
        
        // 3️⃣ Network
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let uiImage = UIImage(data: data) {
                
                // Save to both caches
                ImageCache.shared.set(uiImage, forKey: urlString)
                DiskCacheManager.shared.save(uiImage, forKey: urlString)
                
                self.image = uiImage
            }
        } catch {
            print("Image load error:", error)
        }
    }
}
