//
//  Time.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 14.02.2022.
//

import Foundation

class Time{
    var hour: Int = 0
    var minute: Int = 0
    
    init(hour: Int, minute: Int){
        self.hour = hour
        self.minute = minute
    }
    
    func printTime() -> String{
        return ("\(hour):\(minute)")
    }
}
