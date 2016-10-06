//
//  Note.swift
//  Notes
//
//  Created by Uldis Zingis on 30/09/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import Foundation

class Note: Equatable {
    
    private let kText = "kText"
    private let kTimestamp = "kTimestamp"
    
    var text: String
    let timestamp: Date
    
    init(text: String) {
        self.text = text
        self.timestamp = Date()
    }
    
    init?(dictionary: [String: Any]) {
        guard let text = dictionary[kText] as? String, let timestamp = dictionary[kTimestamp] as? Date else {
            return nil
        }
        self.text = text
        self.timestamp = timestamp
    }
    
    var toDictionary: [String: Any] {
        return [kText: text, kTimestamp: timestamp]
    }
    
    func includesText(text: String) -> Bool {
        return self.text.lowercased().contains(text.lowercased())
    }
}

func ==(lhs: Note, rhs: Note) -> Bool {
    return lhs.text == rhs.text && lhs.timestamp == rhs.timestamp
}
