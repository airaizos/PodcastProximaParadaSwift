//
//  CommonsFunctions.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 16/10/23.
//

import Foundation


func attributedTextFromHTML(_ html: String) -> AttributedString? {
    guard let data = html.data(using: .utf8) else {
        return nil
    }
    do {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        
        let attributtedString = try AttributedString.init(NSAttributedString(data: data, options: options, documentAttributes: nil))
                                                          
        return attributtedString
    } catch {
        print("error attributed STring")
        return nil
    }
}
