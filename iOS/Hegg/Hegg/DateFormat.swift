//
//  DateFormat.swift
//  WeatherForecast
//
//  Created by Mamdouh El Nakeeb on 7/24/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation

class DateFormat {
    
    var formatterDate: DateFormatter
    
    init(format: String) {
        
        formatterDate = DateFormatter()
        formatterDate.timeZone = TimeZone.current
        formatterDate.locale = Locale(identifier: "ar_EG")
        formatterDate.dateFormat = format
    }
    
    func getDateStr(dateMilli: Int) -> String {
        let date = NSDate(timeIntervalSince1970: Double(dateMilli))
        
        return formatterDate.string(from: date as Date)
    }
    
}
