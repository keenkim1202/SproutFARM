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
  
  static let customFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "ko-KR")
    return formatter
  }()
  
  // func latestDateToString(created: Date, updated: Date) -> String {
  //   self.dateFormat = "yyyy/MM/dd HH:mm"
  //   return created < updated ? self.string(from: updated) + "(수정됨)" : self.string(from: created)
  // }
}
