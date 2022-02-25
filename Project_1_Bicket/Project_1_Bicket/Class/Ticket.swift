//
//  Ticket.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 14.02.2022.
//

import Foundation

class Ticket{
    var pnrNo: String
    var passenger: Passenger
    var isBought: Bool // reservation - bought
    var seatCount: Int = 0
    var seats: [Int] = []
    
    init(pnrNo: String, passenger: Passenger, seats: [Int]){
        self.pnrNo = pnrNo
        self.passenger = passenger
        self.seats = seats
        self.seatCount = seats.count
        self.isBought = false
    }
    
    func setType(isBought: Bool){
        self.isBought = isBought
    }
    
    func seatPrint() -> String{
        var msg = "\(passenger.printPassenger())"
        for seat in seats{
            msg.append(", Seat \(seat)")
        }
        return msg
    }
}
