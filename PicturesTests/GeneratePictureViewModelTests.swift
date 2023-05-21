//
//  GeneratePictureViewModelTests.swift
//  PicturesTests
//
//  Created by Andrey on 21.05.2023.
//

@testable import Pictures
import XCTest

final class GeneratePictureViewModelTests: XCTestCase {
    
    var viewModel: GeneratePictureViewModel!
    
    var picturesServiceMock: PicturesServiceMock!
    var favouritesRepositoryMock: FavouritesRepositoryMock!

    override func setUpWithError() throws {
        picturesServiceMock = PicturesServiceMock()
        favouritesRepositoryMock = FavouritesRepositoryMock()
        
        viewModel = GeneratePictureViewModel(
            repository: favouritesRepositoryMock,
            service: picturesServiceMock
        )
    }

    override func tearDownWithError() throws {
        picturesServiceMock = nil
        favouritesRepositoryMock = nil
        viewModel = nil
    }

    func testGeneratingPicture() throws {
        let expectation = XCTestExpectation(description: "Received result from service mock")
        
        picturesServiceMock.generator = { [self] query, completion in
            XCTAssertFalse(viewModel.submitEnabled)
            XCTAssertFalse(viewModel.addToFavouritesEnabled)
            XCTAssertTrue(viewModel.loadingInProgress)
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [self] in
                completion(.success(PictureData(query: query, picture: UIImage())))
                
                XCTAssertTrue(viewModel.queryIsValid)
                XCTAssertTrue(viewModel.submitEnabled)
                XCTAssertTrue(viewModel.addToFavouritesEnabled)
                XCTAssertFalse(viewModel.loadingInProgress)
                XCTAssertNotNil(viewModel.picture)
                
                expectation.fulfill()
            }
        }
        
        viewModel.query = "1234"
        
        XCTAssertTrue(viewModel.queryIsValid)
        XCTAssertTrue(viewModel.submitEnabled)
        XCTAssertFalse(viewModel.addToFavouritesEnabled)
        XCTAssertFalse(viewModel.loadingInProgress)
        
        viewModel.submit()
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testSavingPicture() throws {
        let expectation = XCTestExpectation(description: "Received result from service mock")
        let query = "1234"
        viewModel.query = query
        
        picturesServiceMock.generator = { query, completion in
            completion(.success(PictureData(query: query, picture: UIImage())))
            expectation.fulfill()
        }
        viewModel.submit()
        wait(for: [expectation], timeout: 1)
        
        viewModel.addToFavourites()
        XCTAssertEqual(favouritesRepositoryMock.pictures.count, 1)
        XCTAssertEqual(favouritesRepositoryMock.pictures.first?.query ?? "", query)
    }
}
