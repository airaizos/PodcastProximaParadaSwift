//
//  DetailEpisodeVMTEsts.swift
//  PodcastProximaParadaSwiftTests
//
//  Created by Adrian Iraizos Mendoza on 20/10/23.
//

import XCTest

@testable import PodcastProximaParadaSwift
final class DetailEpisodeVMTEsts: XCTestCase {
    var sut: DetailEpisodeViewModel!
    var episode: Episodio!
    var urls: URLDestination!
    var fileManager: FileManager!
    var network: Network!
  
    override func setUpWithError() throws {
        episode = Episodio.preview
        urls = URLTesting()
        fileManager = FileManager()
        network = Network(urls: urls)
        sut = DetailEpisodeViewModel(episode: episode, network: network, fileManager: fileManager)
    }

    override func tearDownWithError() throws {
        episode = nil
        urls = nil
        fileManager = nil
        network = nil
        sut = nil
    }
    
    func test_changeRate_finalRateShouldBeGrater() throws {
        let initialRate = sut.rate
        
        sut.changeRate(up: true)
        
        let finalRate = sut.rate
        
        XCTAssertGreaterThan(finalRate,initialRate)
    }

    func test_changeRate_initialRateShouldBeGrater() throws {
        sut.stepRate = 1
        let initialRate = sut.rate + 1
        
        sut.changeRate(up: false)
        
        let finalRate = sut.rate
        
        XCTAssertGreaterThan(initialRate, finalRate)
    }
    
    func test_isAudioEpisodeDownloaded_ShouldBeTrue() throws {
        let test = "".data(using: .utf8)
        
        try test?.write(to: sut.audioURL)
        
        let initial = sut.isAudioEpisodeDownloaded()
        
        XCTAssertEqual(initial, true)
    }
    
    
    
    
}
