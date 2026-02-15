//
//  ImageCache.swift
//  LittleLemon
//
//  Created by Leon Haque on 15.2.2026.
//

import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    private let url: URL?
    private let scale: CGFloat
    private let content: (AsyncImagePhase) -> Content
    
    @State private var image: UIImage?
    @State private var phase: AsyncImagePhase = .empty
    
    init(
        url: URL?,
        scale: CGFloat = UIScreen.main.scale,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.content = content
    }
    
    var body: some View {
        content(phase)
            .task(id: url) {
                await loadImage()
            }
    }
    
    private func loadImage() async {
        guard let url = url else {
            phase = .failure(URLError(.badURL))
            return
        }
        
        phase = .empty
        
        // Check cache first
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let cachedResponse = cache.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            phase = .success(Image(uiImage: image))
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Cache the response
            let cachedData = CachedURLResponse(response: response, data: data)
            cache.storeCachedResponse(cachedData, for: request)
            
            // Downsample the image
            if let downsampledImage = downsample(imageData: data, to: CGSize(width: 160, height: 120), scale: scale) {
                phase = .success(Image(uiImage: downsampledImage))
            } else {
                phase = .failure(URLError(.cannotDecodeContentData))
            }
        } catch {
            phase = .failure(error)
        }
    }
    
    private func downsample(imageData: Data, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else {
            return nil
        }
        
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        
        return UIImage(cgImage: downsampledImage)
    }
}
