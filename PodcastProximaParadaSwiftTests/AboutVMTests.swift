//
//  AboutVMTests.swift
//  PodcastProximaParadaSwiftTests
//
//  Created by Adrian Iraizos Mendoza on 20/10/23.
//

import XCTest

@testable import PodcastProximaParadaSwift
final class AboutVMTests: XCTestCase {
    var sut: AboutViewModel!
    
    override func setUpWithError() throws {
        sut = AboutViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_fetchPageAboutMe() async throws {
        let content = await sut.aboutMe()
        
        XCTAssertNotEqual(String(content.description),"**No Content**")
    }
      
}

