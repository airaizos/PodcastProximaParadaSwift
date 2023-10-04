//
//  PodcastProximaParadaSwiftTests.swift
//  PodcastProximaParadaSwiftTests
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import XCTest

@testable import PodcastProximaParadaSwift
final class PodcastProximaParadaSwiftTests: XCTestCase {

    var network: Network!
    var urls: URLDestination!
    
    override func setUpWithError() throws {
        urls = URLProduction()
        network = Network(urls: urls )
    }

    override func tearDownWithError() throws {
        urls = nil
        network = nil
    }

    func test_isDownloadingEpisodes_() async throws {
        let episodio = try await network.fetchJson(url: urls.episodes, type: [Episodio].self).first!
        
        XCTAssertNotNil(episodio)
    }



}
