//
//  CommonsFunctions.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 16/10/23.
//

import Foundation

// Content
func attributedTextFromHTML(_ html: String) -> AttributedString? {
    guard let data = html.data(using: .utf8) else { return nil }
    
    do {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        
        let attributtedString = try AttributedString.init(NSAttributedString(data: data, options: options, documentAttributes: nil))
                                                          
        return attributtedString
    } catch {
        return nil
    }
}

// Reproductor
var timeHMSFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.minute,.second]
    formatter.zeroFormattingBehavior = [.pad]
    return formatter
}()


func formatSecondsToHMS(_ seconds: Double) -> String {
    guard !seconds.isNaN, let text = timeHMSFormatter.string(from: seconds) else {
        return "00:00"
    }
    return text
}
