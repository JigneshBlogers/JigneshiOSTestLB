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

    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}


struct CachedAsyncImage: View {
    let url: URL?
    let placeholder: () -> AnyView
    let content: (Image) -> AnyView

    init(
        url: URL?,
        @ViewBuilder placeholder: @escaping () -> AnyView,
        @ViewBuilder content: @escaping (Image) -> AnyView
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
        
        if let cachedImage = ImageCacheManager.shared.getImage(for: url) {
            self.loadedImage = cachedImage
        } else {
            downloadImage(from: url)
        }
    }

    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
            
            ImageCacheManager.shared.setImage(image, for: url)
            DispatchQueue.main.async {
                self.loadedImage = image
            }
        }.resume()
    }
}

