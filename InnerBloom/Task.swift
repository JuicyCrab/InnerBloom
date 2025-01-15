//
//  Task.swift
//  InnerBloom
//
//  Created by Eyasu Smieja on 1/15/25.
//


import SwiftUI

struct Task: Identifiable {
    var id: UUID = .init()
    var title: String
    var caption: String
    var date: Date = .init()
    var isCompleted: Bool = false
    var tint: Color
}

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}

import SwiftUI


