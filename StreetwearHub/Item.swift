//
//  Item.swift
//  StreetwearHub
//
//  Created by Venzislav on 17.03.25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
