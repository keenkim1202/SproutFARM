//
//  DateFormatter++Extension.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

extension DateFormatter {
    func toDate(date: String) -> Date {
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return self.date(from: date)!
    }
    
    func toString(date: Date) -> String {
        self.dateFormat = "yyyy/MM/dd HH:mm"
        return self.string(from: date)
    }
}
