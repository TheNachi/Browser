//
//  String+Extensions.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import Foundation

extension String {
    mutating func fixMissingScheme() -> String {
        if !self.contains("https://") && !self.contains("http://") {
            return self.contains("//") ? "https:\(self)".stripString() : "https://\(self)".stripString()
        }
        return self
    }
    
    func stripString() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}
