import Foundation

// Date extension to add formatting capabilities and week utilities
extension Date {
    // Helper to fetch the current week's range
    func fetchWeek() -> [Date.WeekDay] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .weekOfYear, for: self) else {
            return [] // Return an empty array if the range cannot be determined
        }
        
        return range.compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: self).map {
                Date.WeekDay(date: $0)
            }
        }
    }

    // Helper to get the previous week
    func createPreviousWeek() -> [Date.WeekDay] {
        var date = self
        date = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: date)!
        return date.fetchWeek()
    }

    // Helper to get the next week
    func createNextWeek() -> [Date.WeekDay] {
        var date = self
        date = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date)!
        return date.fetchWeek()
    }

    struct WeekDay: Identifiable {
        var id = UUID()
        var date: Date
    }

}

