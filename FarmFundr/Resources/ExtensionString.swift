//
//  ExtensionString.swift
//  FarmFundr
//
//  Created by Anupriya on 03/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}

// Conver String to DateStr

func stringToDatestr(date : String) -> String{
    var dateStr : String = ""
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMM dd,yyyy"
    if let date = dateFormatterGet.date(from: date) {
        dateStr = dateFormatterPrint.string(from: date)
       // print("DATEStr",dateStr)
        return dateStr
    } else {
        print("There was an error decoding the string")
        return ""
    }
}

//MARK:-  Convert String to TimeString

func stringToTimeStr(time : String) -> String{
    var timeStr : String = ""
    let timeFormatterGet = DateFormatter()
    timeFormatterGet.dateFormat = "HH:mm:ss"
    let timeFormaterPrint = DateFormatter()
    timeFormaterPrint.dateFormat = "h:mm a"
    if let time = timeFormatterGet.date(from: time){
       timeStr = timeFormaterPrint.string(from: time)
        return timeStr
    }else{
        print("There was an error decoding the string")
        return timeStr
    }
}
