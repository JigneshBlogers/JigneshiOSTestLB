//
//  CharactersViewModelTests.swift
//  iOSTestJigneshLBTests
//
//  Created by jignesh kalantri on 05/11/24.
//

import XCTest
import Combine
@testable import iOSTestJigneshLB

class CharactersViewModelTests: XCTestCase {
    private var viewModel: CharactersViewModel!
    var mockNetworkManager: MockNetworkManager! // Define as non-optional
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockNetworkManager = MockNetworkManager() // Initialize as a non-optional instance
        viewModel = CharactersViewModel(networkManager: mockNetworkManager) // Pass the non-optional instance
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchCharactersSuccess() {
        // Arrange
        let expectedCharacters = [
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: "Scientist",
                gender: "Male",
                image: "https://example.com/image.png",
                url: "https://example.com/character/1"
            )
        ]
        let characterResponse = CharacterResponse(results: expectedCharacters)
        mockNetworkManager.result = .success(characterResponse)
        
        // Create an expectation
        let expectation = self.expectation(description: "Fetching characters successfully")
        
        // Act
        viewModel.fetchCharacters()
        
        // Wait for async operations to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Assert
            XCTAssertEqual(self.viewModel.characters.count, expectedCharacters.count)
            XCTAssertNil(self.viewModel.errorMessage)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill() // Fulfill the expectation
        }
        
        // Wait for expectations
        waitForExpectations(timeout: 1.0, handler: nil)
    }


    func testFetchCharactersFailure() {
        // Arrange
        mockNetworkManager.result = .failure(.networkError(NSError(domain: "", code: -1, userInfo: nil)))

        // Act
        viewModel.fetchCharacters()

        // Wait for async operations to complete
        let expectation = self.expectation(description: "Wait for failure response")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Assert
            XCTAssertTrue(self.viewModel.characters.isEmpty)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }

    func testSetErrorMessageNil() {
        // Arrange
        viewModel.errorMessage = ErrorMessage(message: "Some error") // Assign an ErrorMessage instance
        
        // Act
        viewModel.setErrorMessageNil()
        
        // Assert
        XCTAssertNil(viewModel.errorMessage) // Now it should be nil
    }
}

class MockNetworkManager: NetworkManagerProtocol {
    var result: Result<CharacterResponse, NetworkError>?

    func fetchCharacters(completion: @escaping (Result<iOSTestJigneshLB.CharacterResponse, iOSTestJigneshLB.NetworkError>) -> Void) {
        if let result = result {
            completion(result)
        } else {
            completion(.failure(.noData)) // Handle unexpected case
        }
    }
}


