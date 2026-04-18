//
//  DiskCache.swift
//  LocalEventExplorer
//
//  Created by Swati Seera on 2026-04-18.
//

import UIKit

final class DiskCacheManager {
    
    static let shared = DiskCacheManager()
    private init() {}
    
    private let fileManager = FileManager.default
    
    private lazy var cacheDirectory: URL = {
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        let dir = urls[0].appendingPathComponent("ImageCache", isDirectory: true)
        
        if !fileManager.fileExists(atPath: dir.path) {
            try? fileManager.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir
    }()
    
    private func fileURL(for key: String) -> URL {
        let fileName = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? UUID().uuidString
        return cacheDirectory.appendingPathComponent(fileName)
    }
    
    func save(_ image: UIImage, forKey key: String) {
        let url = fileURL(for: key)
        guard let data = image.jpegData(compressionQuality: 0.9) else { return }
        try? data.write(to: url)
    }
    
    func load(forKey key: String) -> UIImage? {
        let url = fileURL(for: key)
        guard fileManager.fileExists(atPath: url.path),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else { return nil }
        return image
    }
}
