//
//  iTunesArtworkExplorer_for_MacTests.swift
//  iTunesArtworkExplorer for MacTests
//
//  Created by SaitoYuta on 2016/08/06.
//  Copyright © 2016年 SaitoYuta. All rights reserved.
//

import XCTest
@testable import iTunesArtworkExplorer_for_Mac

class iTunesArtworkExplorer_for_MacTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testExample() {
        let model = iTunesSearchAPI(term: "test", country: .jp, media: .music(ent: nil, attr: nil) , limit: 10, lang: .Ja )
//        model.setArtwork()
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
