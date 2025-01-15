//
//  Journal.swift
//  InnerBloom
//
//  Created by Eyasu Smieja on 1/16/25.
//

import Foundation

// Journal Model
struct Journal: Identifiable {
    var id = UUID()    // Unique identifier
    var title: String
    var caption: String
    var date: Date
}
