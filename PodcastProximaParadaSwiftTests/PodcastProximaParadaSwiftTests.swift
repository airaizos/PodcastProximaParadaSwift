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
        
        urls = URLTesting()
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


    func test_CategoriesURL_shouldBeGraterThan0() async throws {
        let categories = try await network.fetchJson(url: URL.categories, type: [APIPostCategory].self)
        
        XCTAssertGreaterThan(categories.count, 0)
    }
 
    func test_FetchEpisodes_shouldBeGraterThan0() async throws {
        let episodios = await network.fetchEpisodes()
        
        XCTAssertGreaterThan(episodios.count, 0)
    }
    
//    func test_FetchPages_ShouldNotBeNoContent() async throws {
//        let page = await network.fetchPageContent(page: .aboutMe)
//        
//        XCTAssertNotEqual(page,"**No Content**")
//    }
    
    func test_FetchCategories_() async throws {
        let categories = await network.fetchCategories()
        
        XCTAssertGreaterThan(categories.count, 0)
    }
    
}
