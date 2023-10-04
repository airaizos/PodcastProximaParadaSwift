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
    var decoder: JSONDecoder!
    
    override func setUpWithError() throws {
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        urls = URLProduction()
        network = Network(urls: urls,decoder: decoder)
    }

    override func tearDownWithError() throws {
        urls = nil
        network = nil
    }

    func test_isDownloadingEpisodes_() async throws {
        let episodio = try await network.fetchJson(url: urls.episodes, type: [APIEpisodio].self).first!
        
        XCTAssertNotNil(episodio)
    }



}
