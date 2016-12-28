//
//  MusicCenterTests.swift
//  MusicCenterTests
//
//  Created by sylvain vincent on 07/12/2016.
//  Copyright © 2016 sylvain vincent. All rights reserved.
//

import XCTest
@testable import MusicCenter

class MusicCenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
   
        XCTAssertTrue(ViewController.addition(a: 10, b: 2) == 12)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
