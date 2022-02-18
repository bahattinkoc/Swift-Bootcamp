//
//  Date.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 14.02.2022.
//

import Foundation

class Date{
    var day: Int = 1
    var mounth: Int = 1
    var year: Int = 2022
    
    init(day: Int, mounth: Int, year: Int){
        self.day = day
        self.mounth = mounth
        self.year = year
    }
    
    func printDate() -> String{
        return ("\(day)/\(mounth)/\(year)")
    }
}
