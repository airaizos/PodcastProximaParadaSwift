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
        
        print(episodio.content.rendered)
        XCTAssertNotNil(episodio)
    }

    func test_ConvertHTMLToString() throws {
        
        let html = """
        "\n<p><strong>Miércoles 27.Sep.2023</strong></p>\n\n\n\n<p><strong>En estos días…</strong></p>\n\n\n\n<p><strong>…he cumplido …</strong></p>\n\n\n\n<p>7 días con 6 o más horas de estudio</p>\n\n\n\n<p>5  Ofertas aplicadas</p>\n\n\n\n<p><strong>… he avanzado en el proyecto..</strong></p>\n\n\n\n<p>Estoy avanzando en las vistas (Login, Vista mensual, anual). He trabajado en las estadísticas del juego. Cuántos dailies completados, cuando encuentros cumplimentados, las rachas. &nbsp;</p>\n\n\n\n<p><strong>Libro(s) que estoy leyendo …&nbsp;</strong></p>"
        """
        
        if let data = html.data(using: .isoLatin1, allowLossyConversion: true),
    //    let data = Data(latin)
        
        let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            let attStr = AttributedString(attributedString)
         //   XCTAssertNotNil(attStr)
            print(attStr)
        }
    }

    func test_CategoriesURL_shouldBeGraterThan0() async throws {
        let categories = try await network.fetchJson(url: URL.categoriesURL, type: [APIPostCategory].self)
        
        XCTAssertGreaterThan(categories.count, 0)
        
    }
    
}
