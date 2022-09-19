//
//  Date + Ext.swift
//  SpaceXTest
//
//  Created by Cristian Ciupac on 19.09.2022.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension String {
    var spaceXTime: String {
        
        let isoTime = Formatter.iso8601withFractionalSeconds.date(from: self)!
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateStyle = .medium
        dtFormatter.timeStyle = .none

        return dtFormatter.string(from: isoTime)
    }
}
