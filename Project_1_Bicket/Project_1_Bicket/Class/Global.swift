//
//  Global.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 16.02.2022.
//

import Foundation
import UIKit
import CoreData

// Singleton Design Pattern
class Global{
    static let instance = Global()
    var selectedBus: Bus?
    var selectedTicket: Ticket?
    private let appDelegate: AppDelegate?
    let context: AnyObject?
    var buses: [Bus] = [Bus]()
    
    private init() {
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        context = appDelegate?.persistentContainer.viewContext
    }
    
    func addTicket(busId: Int, pnrNo: String, date: String, time: String, isBought: Bool, seats: [Int], passenger: Passenger){
        var data = NSEntityDescription.insertNewObject(forEntityName: "TicketDB", into: context as! NSManagedObjectContext)
        data.setValue(busId, forKey: "busId")
        data.setValue(pnrNo, forKey: "pnrNo")
        data.setValue(date, forKey: "date")
        data.setValue(time, forKey: "time")
        data.setValue(isBought, forKey: "isBought")
        
        do {
            try (context as! NSManagedObjectContext).save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        // SeatsDB ye ekle
        for seat in seats{
            data = NSEntityDescription.insertNewObject(forEntityName: "SeatsDB", into: context as! NSManagedObjectContext)
            
            data.setValue(pnrNo, forKey: "pnrNo")
            data.setValue(seat, forKey: "seatNo")
            
            do {
                try (context as! NSManagedObjectContext).save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        // PassengerDB ye ekle
        data = NSEntityDescription.insertNewObject(forEntityName: "PassengerDB", into: context as! NSManagedObjectContext)
        
        data.setValue(passenger.id, forKey: "id")
        data.setValue(passenger.name, forKey: "name")
        data.setValue(passenger.surname, forKey: "surname")
        
        do {
            try (context as! NSManagedObjectContext).save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        // PassengerTicketDB ye ekle
        data = NSEntityDescription.insertNewObject(forEntityName: "PassengerTicketDB", into: context as! NSManagedObjectContext)
        
        data.setValue(passenger.id, forKey: "passengerId")
        data.setValue(pnrNo, forKey: "pnrNo")
        
        do {
            try (context as! NSManagedObjectContext).save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func addBus(from: String, to: String, date: String, time: String, fee: Int){
        let data = NSEntityDescription.insertNewObject(forEntityName: "BusDB", into: context as! NSManagedObjectContext)
        let id = Int.random(in: 0..<500000)
        data.setValue(id, forKey: "id")
        data.setValue(from, forKey: "from")
        data.setValue(to, forKey: "to")
        data.setValue(date, forKey: "date")
        data.setValue(time, forKey: "time")
        data.setValue(fee, forKey: "fee")
        
        do {
            try (context as! NSManagedObjectContext).save()
            let dateStr = date.split(separator: "/")
            let timeStr = time.split(separator: ":")
            buses.append(Bus(id: id, from: from, to: to, date: Date(day: Int(dateStr[1]) ?? 1, mounth: Int(dateStr[0]) ?? 1, year: Int(dateStr[2]) ?? 1), time: Time(hour: Int(timeStr[0]) ?? 1, minute: Int(timeStr[1]) ?? 1), fee: fee))
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getArrayFromDB(entityName: String) -> NSArray{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false // hata dönderirse boşver
        
        do {
            let result: NSArray = try (context as! NSManagedObjectContext).fetch(request) as NSArray
            return result
        } catch let error as NSError {
            print(error)
            return NSArray()
        }
    }
    
    func loadDB(){
        buses.removeAll()
        
        // VT daki otobüsleri buses değişkenine ekliyoruz
        let busesFromDB = getArrayFromDB(entityName: "BusDB")
        if busesFromDB.count > 0{
            for item in busesFromDB as! [NSManagedObject]{
                let dateStr = (item.value(forKey: "date") as! String).split(separator: "/")
                let timeStr = (item.value(forKey: "time") as! String).split(separator: ":")
                buses.append(Bus(id: item.value(forKey: "id") as! Int, from: item.value(forKey: "from") as! String, to: item.value(forKey: "to") as! String, date: Date(day: Int(dateStr[1]) ?? 1, mounth: Int(dateStr[0]) ?? 1, year: Int(dateStr[2]) ?? 1), time: Time(hour: Int(timeStr[0]) ?? 1, minute: Int(timeStr[1]) ?? 1), fee: item.value(forKey: "fee") as! Int))
            }
        }
        
        // Otobüslerin varsa yolcularıda buses değişkenindeki otobüslere ekleniyor
        let ticketsFromDB = getArrayFromDB(entityName: "TicketDB") as! [NSManagedObject]
        let seatsFromDB = getArrayFromDB(entityName: "SeatsDB") as! [NSManagedObject]
        let passengerTicketDB = getArrayFromDB(entityName: "PassengerTicketDB") as! [NSManagedObject]
        let passengerDB = getArrayFromDB(entityName: "PassengerDB") as! [NSManagedObject]
        
        for bus in buses{
            for ticket in ticketsFromDB{
                if ticket.value(forKey: "busId") as! Int == bus.id{
                    var seats = [Int]()
                    for seat in seatsFromDB{
                        if seat.value(forKey: "pnrNo") as! String == ticket.value(forKey: "pnrNo") as! String{
                            seats.append(seat.value(forKey: "seatNo") as! Int)
                        }
                    }
                    
                    var passengerId: String?
                    for passengerTicket in passengerTicketDB{
                        if passengerTicket.value(forKey: "pnrNo") as! String == ticket.value(forKey: "pnrNo") as! String{
                            passengerId = passengerTicket.value(forKey: "passengerId") as? String
                            break
                        }
                    }
                    
                    var currentPassenger: Passenger?
                    for passengerItem in passengerDB{
                        if passengerItem.value(forKey: "id") as? String == passengerId{
                            currentPassenger = Passenger(name: passengerItem.value(forKey: "name") as! String, surname: passengerItem.value(forKey: "surname") as! String, id: passengerId!)
                            break
                        }
                    }
                    
                    bus.addTicket(ticket: Ticket(pnrNo: ticket.value(forKey: "pnrNo") as! String, passenger: currentPassenger!, seats: seats))
                }
            }
        }
    }
}
