//
//  @testable import PodcastProximaParadaSwift.swift
//  PodcastProximaParadaSwiftTests
//
//  Created by Adrian Iraizos Mendoza on 20/10/23.
//

import XCTest
@testable import PodcastProximaParadaSwift

final class CommonsTests: XCTestCase {

    func test_attributedTextFromHTML_ShouldNotNil() throws {

       let result = attributedTextFromHTML("A")
        
        XCTAssertNotNil(result)
    }

    func test_formatSecondsTOHMS_shouldBe00_01() throws {
        let result = formatSecondsToHMS(1)
        
        XCTAssertEqual(result, "00:01")
    }
    
}
