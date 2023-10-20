//
//  EpisodesListVMTests.swift
//  PodcastProximaParadaSwiftTests
//
//  Created by Adrian Iraizos Mendoza on 20/10/23.
//

import XCTest

@testable import PodcastProximaParadaSwift
final class EpisodesListVMTests: XCTestCase {
    var urls: URLDestination!
    var network: Network!
    var sut: EpisodesListViewModel!
    
    override func setUpWithError() throws {
        urls = URLTesting()
        network = Network(urls: urls)
       sut = EpisodesListViewModel(network: network)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_fetchEpisodes_() async throws {
        let episodes = Episodio.previewTenEpisodes
        
        let newEpisodes = await sut.fetchEpisodes(episodes)
        
        XCTAssertGreaterThan(newEpisodes.count, 0)
    }


}
