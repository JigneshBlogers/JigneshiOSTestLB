//
//  ImageCacheManager.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 06/11/24.
//

import Foundation
import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}

    private var cache = NSCache<NSURL, UIImage>()

    func fetchImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        // Check cache first
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }
        
        // Download if not cached
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            // Cache the image
            self.cache.setObject(image, forKey: url as NSURL)
            completion(image)
        }.resume()
    }
}


struct CachedAsyncImage<Placeholder: View, Content: View>: View {
    let url: URL?
    let placeholder: () -> Placeholder
    let content: (Image) -> Content

    init(
        url: URL?,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder content: @escaping (Image) -> Content
    ) {
        self.url = url
        self.placeholder = placeholder
        self.content = content
    }

    @State private var loadedImage: UIImage?

    var body: some View {
        Group {
            if let uiImage = loadedImage {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }

    private func loadImage() {
        guard let url = url else { return }
        
        ImageCacheManager.shared.fetchImage(for: url) { image in
            DispatchQueue.main.async {
                self.loadedImage = image
            }
        }
    }
}

