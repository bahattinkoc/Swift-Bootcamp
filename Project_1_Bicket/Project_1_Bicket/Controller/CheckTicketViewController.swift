//
//  CheckTicketViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 22.02.2022.
//

import UIKit
import CoreData // PNR-BK1137732522022117

class CheckTicketViewController: UIViewController {
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var pnrTextField: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    private var customView: UIView!
    private var msgLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        welcomeLabel.layer.cornerRadius = 10
        welcomeLabel.layer.shadowColor = UIColor.lightGray.cgColor
        welcomeLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        welcomeLabel.layer.shadowOpacity = 0.5
        welcomeLabel.layer.shadowRadius = 2.0
        welcomeLabel.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pnrTextField.text = ""
        
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        
        // Label kalınlaştırma yapılıyor.
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 45)]
        let attributedString = NSMutableAttributedString(string:"bicket", attributes:attrs)
        let normalString = NSMutableAttributedString(string:".com")
        attributedString.append(normalString)
        brandLabel.attributedText = attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Check Ticket"
        navigationController?.isNavigationBarHidden = true
    }
    
    private func showAlert(msg: String){
        let alertView = UIAlertController(title: "Information", message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        // Ticket ve Bus lazım - pnrnodan ikisinide bulman lazım
        guard pnrTextField.text!.count > 0 else { return }
        
        let pnr = pnrTextField.text
        var bus: Bus?
        var ticket: Ticket?
        var passenger: Passenger?
        var seats = [Int]()
        var isFound = false
        
        let ticketsFromDB = Global.instance.getArrayFromDB(entityName: "TicketDB") as! [NSManagedObject]
        let seatsFromDB = Global.instance.getArrayFromDB(entityName: "SeatsDB") as! [NSManagedObject]
        let passengerTicketDB = Global.instance.getArrayFromDB(entityName: "PassengerTicketDB") as! [NSManagedObject]
        let passengerDB = Global.instance.getArrayFromDB(entityName: "PassengerDB") as! [NSManagedObject]
        let busDB = Global.instance.getArrayFromDB(entityName: "BusDB") as! [NSManagedObject]
        
        for ticketItem in ticketsFromDB{
            if pnr == ticketItem.value(forKey: "pnrNo") as? String{
                // Ticketı bulduk
                // Rezerve edimiş. Ticket detail sayfasına yönlendir.
                // Passenger ve koltukları bul
                    
                let busId = ticketItem.value(forKey: "busId") as! Int
                for busItem in busDB{
                    if busId == busItem.value(forKey: "id") as! Int{
                        let dateStr = (busItem.value(forKey: "date") as! String).split(separator: "/")
                        let timeStr = (busItem.value(forKey: "time") as! String).split(separator: ":")
                        bus = Bus(id: busId, from: busItem.value(forKey: "from") as! String, to: busItem.value(forKey: "to") as! String, date: Date(day: Int(dateStr[1]) ?? 1, mounth: Int(dateStr[0]) ?? 1, year: Int(dateStr[2]) ?? 1), time: Time(hour: Int(timeStr[0]) ?? 1, minute: Int(timeStr[1]) ?? 1), fee: busItem.value(forKey: "fee") as! Int)
                    }
                }
                
                var passengerId: String?
                for passengerTicketItem in passengerTicketDB{
                    if passengerTicketItem.value(forKey: "pnrNo") as? String == pnr{
                        passengerId = passengerTicketItem.value(forKey: "passengerId") as? String
                        break
                    }
                }
                
                for passengerItem in passengerDB{
                    if passengerItem.value(forKey: "id") as? String == passengerId{
                        passenger = Passenger(name: passengerItem.value(forKey: "name") as! String, surname: passengerItem.value(forKey: "surname") as! String, id: passengerId!)
                        break
                    }
                }
                
                for seat in seatsFromDB {
                    if pnr == seat.value(forKey: "pnrNo") as! String{
                        seats.append(seat.value(forKey: "seatNo") as! Int)
                    }
                }
                
                ticket = Ticket(pnrNo: pnr!, passenger: passenger!, seats: seats)
                ticket?.isBought = ticketItem.value(forKey: "isBought") as! Bool
                
                isFound = true
                Global.instance.selectedBus = bus
                Global.instance.selectedTicket = ticket
                UserDefaults.standard.set(true, forKey: "isPnr")
                let detailPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TicketDetailViewController")
                navigationController?.pushViewController(detailPage, animated: true)
                break
                
            }
        }
        
        if !isFound{
            showAlert(msg: "Not Found")
        }
    }
}
