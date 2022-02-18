//
//  Ticket.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 14.02.2022.
//

import Foundation

class Ticket{
    var passenger: Passenger
    var date: Date
    var time: Time
    var isBought: Bool // reservation - bought
    var seatCount: Int = 0
    var seats: [Int] = []
    
    init(passenger: Passenger, date: Date, time: Time, seats: [Int]){
        self.passenger = passenger
        self.date = date
        self.time = time
        self.seats = seats
        self.seatCount = seats.count
        self.isBought = false
    }
    
    func setType(isBought: Bool){
        self.isBought = isBought
    }
    
    func seatPrint() -> String{
        var msg = "\(passenger.printPassenger()), \(date.printDate()), \(time.printTime())"
        for seat in seats{
            msg.append(", Seat \(seat)")
        }
        return msg
    }
}
