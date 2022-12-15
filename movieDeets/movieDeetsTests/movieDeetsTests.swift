//
//  movieDeetsTests.swift
//  movieDeetsTests
//
//  Created by Stuart Ziane on 14/12/2022.
//

import XCTest
@testable import movieDeets

final class movieDeetsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_APIManager_canBuildValidUrlFromSearchString() throws {
        let apiManager = APIManager()
        
        let url = apiManager.buildRequestUrl(queryType: .searchByTitle, with: "Test")
        
        XCTAssertEqual(url, URL(string: "http://www.omdbapi.com/?s=Test&plot=full&apikey=b620043c"))
    }
    
    func test_APIManager_canBuildValidUrlFromImdbID() throws {
        let apiManager = APIManager()
        
        let url = apiManager.buildRequestUrl(queryType: .searchById, with: "tt0112573")
        
        XCTAssertEqual(url, URL(string: "http://www.omdbapi.com/?i=tt0112573&plot=full&apikey=b620043c"))
    }

}
