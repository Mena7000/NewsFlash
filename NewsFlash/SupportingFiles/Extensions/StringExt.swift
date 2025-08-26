//
//  StringExt.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import Foundation

extension String {
    //"dd MMM yyyy    h:mm a"
    func dateString(format: String = "dd MMM, yyyy") -> String {
        let dateString = self //"19-08-2015 09:00 AM"
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 60)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"//"dd-MM-yyyy hh:mm a"
        if let dateFromString = dateFormatter.date(from: dateString) {
            dateFormatter.locale = Locale(identifier: "en") as Locale
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 60)// .current
            dateFormatter.dateFormat = format //"dd-MM-yyyy hh:mm a Z"
            dateFormatter.string(from: dateFromString)  // 19-08-2015 06:00 AM -0300"
            return dateFormatter.string(from: dateFromString)
        }
        
        return ""
    }
}
