//
//  Passenger.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 14.02.2022.
//

import Foundation

class Passenger{
    var name: String = ""
    var surname: String = ""
    var id: String = ""
    
    init(name: String, surname: String, id: String){
        self.name = name
        self.surname = surname
        self.id = id
    }
    
    func printPassenger() -> String{
        return ("\(name) \(surname) \(id)")
    }
}
