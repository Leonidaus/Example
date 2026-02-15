import SwiftUI

// Add an in-memory cache
class ImageCache {
    static let shared = ImageCache()
    private var cache: [String: UIImage] = [:]
    private let lock = NSLock()
    
    func get(_ key: String) -> UIImage? {
        lock.lock()
        defer { lock.unlock() }
        return cache[key]
    }
    
    func set(_ key: String, image: UIImage) {
        lock.lock()
        defer { lock.unlock() }
        cache[key] = image
    }
}

struct CachedAsyncImage<Content: View>: View {
    private let url: URL?
    private let scale: CGFloat
    private let content: (AsyncImagePhase) -> Content
    
    @State private var phase: AsyncImagePhase = .empty
    
    init(url: URL?, scale: CGFloat = UIScreen.main.scale, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = scale
        self.content = content
    }
    
    var body: some View {
        content(phase)
            .onAppear {
                loadImageSync()
            }
    }
    
    private func loadImageSync() {
        guard let url = url else {
            phase = .failure(URLError(.badURL))
            return
        }
        
        let urlString = url.absoluteString
        
        // Check in-memory cache first (instant)
        if let cachedImage = ImageCache.shared.get(urlString) {
            phase = .success(Image(uiImage: cachedImage))
            return
        }
        
        // Check URLCache
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let cachedResponse = cache.cachedResponse(for: request),
           let cachedImage = Self.downsample(imageData: cachedResponse.data, to: CGSize(width: 160, height: 120), scale: scale) {
            ImageCache.shared.set(urlString, image: cachedImage)
            phase = .success(Image(uiImage: cachedImage))
            return
        }
        
        // If not in cache, load asynchronously
        phase = .empty
        Task {
            if let uiImage = await Self.fetchAndProcess(url: url, scale: scale) {
                ImageCache.shared.set(urlString, image: uiImage)
                await MainActor.run {
                    phase = .success(Image(uiImage: uiImage))
                }
            } else {
                await MainActor.run {
                    phase = .failure(URLError(.cannotDecodeContentData))
                }
            }
        }
    }
    
    static func fetchAndProcess(url: URL, scale: CGFloat) async -> UIImage? {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        // Check Disk/URLCache first
        if let cachedResponse = cache.cachedResponse(for: request) {
            return downsample(imageData: cachedResponse.data, to: CGSize(width: 160, height: 120), scale: scale)
        }
        
        // Download if not cached
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let cachedData = CachedURLResponse(response: response, data: data)
            cache.storeCachedResponse(cachedData, for: request)
            
            return downsample(imageData: data, to: CGSize(width: 160, height: 120), scale: scale)
        } catch {
            print("❌ Failed to download image: \(url.absoluteString), error: \(error)")
            return nil
        }
    }
    
    static func downsample(imageData: Data, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
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
