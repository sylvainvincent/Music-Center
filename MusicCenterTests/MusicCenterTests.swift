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
    
    func testMusic(){
        let audioData = NSData(base64Encoded: "E34" , options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        let music = Music.init(name: "test", url: "/music", data: audioData)
        XCTAssertNotNil(music)
    }
    
    func testRequest(){
     /*   let expectation = expectation(description: "test")
        var viewController = ViewController()
        viewController.getMusics(musicUrl: "http://localhost:8080/musics"){ success in
            XCTAssertTrue(success)
            
            // Don't forget to fulfill the expectation in the async callback
            expectation.fulfill()
        }
      */
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
          
        }
    }
    
}
