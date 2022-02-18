//
//  Bus.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 14.02.2022.
//

import Foundation


class Bus{
    var id: Int
    var from: String
    var to: String
    var date: Date
    var time: Time
    var fee: Int
    var seats: [Int] = []
    var tickets: [Ticket] = []
    
    init(id: Int, from: String, to: String, date: Date, time: Time, fee: Int){
        self.id = id
        self.from = from
        self.to = to
        self.date = date
        self.time = time
        self.fee = fee
    }
    
    func addTicket(ticket: Ticket) -> Bool{
        // koltuk numaralarını kotrol et uygunsa ticket a ekle
        var isOk = true
        for ticketSeat in ticket.seats{
            if self.seats.contains(ticketSeat){
                isOk = false
                break
            }
        }
        
        if isOk{
            for ticketSeat in ticket.seats{
                self.seats.append(ticketSeat)
            }
            self.tickets.append(ticket)
        }
        
        return isOk
    }
    
    func autoFill(limit: Int){
        var list = [Int]()
        var _limit = limit
        while _limit >= 1{
            list.append(_limit)
            _limit -= 1
        }
        
        addTicket(ticket: Ticket(passenger: Passenger(name: "Bahattin", surname: "Koç", id: 58), date: date, time: time, seats: list))
    }
}
