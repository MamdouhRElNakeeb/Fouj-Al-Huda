//
//  EnglishToArabic.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/7/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation

class EnglishToArabic {
    
    func getMonthName(monthNo: Int) -> String{
        
        switch monthNo {
        case 1:
            return "يناير"
        case 2:
            return "فبراير"
        case 3:
            return "مارس"
        case 4:
            return "أبريل"
        case 5:
            return "مايو"
        case 6:
            return "يونيو"
        case 7:
            return "يوليو"
        case 8:
            return "أغسطس"
        case 9:
            return "سبتمبر"
        case 10:
            return "أكتوبر"
        case 11:
            return "نوفمبر"
        case 12:
            return "ديسمبر"
        default:
            return ""
        }
    }
    
    func getDayName(dayName: String) -> String{
        
        switch dayName {
        case "Sa":
            return "السبت"
        case "Su":
            return "الأحد"
        case "Mo":
            return "الأثنين"
        case "Tu":
            return "الثلاثاء"
        case "We":
            return "الأربعاء"
        case "Th":
            return "الخميس"
        case "Fr":
            return "الجمعة"
        default:
            return ""
        }
        
    }
    
    func getArabicNo(number: String) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar_EG")   // you can specify locale that you want
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        
        return String(describing: formatter.number(from: number))

    }
}
