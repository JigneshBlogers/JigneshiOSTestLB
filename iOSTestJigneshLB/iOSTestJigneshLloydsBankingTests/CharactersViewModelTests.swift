//
//  CharactersViewModelTests.swift
//  iOSTestJigneshLBTests
//
//  Created by jignesh kalantri on 05/11/24.
//

import XCTest
import Combine
@testable import iOSTestJigneshLB


class ImageCacheManagerTests: XCTestCase {
    var mockCacheManager: MockImageCacheManager!
    var imageURL: URL!

    override func setUp() {
        super.setUp()
        mockCacheManager = MockImageCacheManager()
        imageURL = URL(string: "https://example.com/image.png")
    }

    override func tearDown() {
        mockCacheManager = nil
        imageURL = nil
        super.tearDown()
    }

    func testFetchImage_FromCache() {
        // Arrange
        let sampleImage = UIImage(systemName: "person")!
        mockCacheManager.setMockImage(sampleImage, for: imageURL)

        // Act
        var fetchedImage: UIImage?
        mockCacheManager.fetchImage(for: imageURL) { image in
            fetchedImage = image
        }

        // Assert
        XCTAssertEqual(fetchedImage, sampleImage)
        XCTAssertTrue(mockCacheManager.fetchImageCalled)
    }

    func testFetchImage_NotInCache() {
        // Arrange
        let nonCachedURL = URL(string: "https://example.com/nonexistent.png")!

        // Act
        var fetchedImage: UIImage?
        mockCacheManager.fetchImage(for: nonCachedURL) { image in
            fetchedImage = image
        }

        // Assert
        XCTAssertNil(fetchedImage)
        XCTAssertTrue(mockCacheManager.fetchImageCalled)
    }

    func testFetchImage_CacheAndRetrieve() {
        // Arrange
        let sampleImage = UIImage(systemName: "star")!
        mockCacheManager.setMockImage(sampleImage, for: imageURL)

        // Act
        var fetchedImage: UIImage?
        mockCacheManager.fetchImage(for: imageURL) { image in
            fetchedImage = image
        }

        // Assert
        XCTAssertEqual(fetchedImage, sampleImage)
    }
}


class MockImageCacheManager: ImageCacheManagerProtocol {
    private var mockCache: [URL: UIImage] = [:]
    var fetchImageCalled: Bool = false

    // Simulates fetching an image from the cache or "network"
    func fetchImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        fetchImageCalled = true
        if let cachedImage = mockCache[url] {
            completion(cachedImage)
        } else {
            completion(nil) // Simulate missing image
        }
    }

    // Allows test cases to prepopulate the mock cache
    func setMockImage(_ image: UIImage, for url: URL) {
        mockCache[url] = image
    }

    // Optional utility for clearing the cache between tests
    func clearCache() {
        mockCache.removeAll()
        fetchImageCalled = false
    }
}

protocol ImageCacheManagerProtocol {
    /// Fetches an image for a given URL.
    /// - Parameters:
    ///   - url: The URL of the image to fetch.
    ///   - completion: A closure that is called with the fetched `UIImage` or `nil` if the fetch fails.
    func fetchImage(for url: URL, completion: @escaping (UIImage?) -> Void)
}
