//
//  View.swift
//  InnerBloom
//
//  Created by Eyasu Smieja on 1/15/25.
//

import SwiftUI


extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View{
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    //checking two dates are the same
    
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
}
