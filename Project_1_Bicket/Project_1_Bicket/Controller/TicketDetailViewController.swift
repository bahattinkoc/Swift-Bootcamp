//
//  TicketDetailViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 18.02.2022.
//

import UIKit

class TicketDetailViewController: UIViewController {

    @IBOutlet weak var busView: UIView!
    @IBOutlet weak var passengerView: UIView!
    @IBOutlet weak var userInformationLabel: UILabel!
    @IBOutlet weak var busInformationLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userUsernameLabel: UILabel!
    @IBOutlet weak var fromToLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    let ticket = Global.instance.selectedTicket!
    let bus = Global.instance.selectedBus!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        passengerView.layer.cornerRadius = 10
        passengerView.layer.shadowColor = UIColor.lightGray.cgColor
        passengerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        passengerView.layer.shadowOpacity = 0.5
        passengerView.layer.shadowRadius = 2.0
        
        busView.layer.cornerRadius = 10
        busView.layer.shadowColor = UIColor.lightGray.cgColor
        busView.layer.shadowOffset = CGSize(width: 0, height: 0)
        busView.layer.shadowOpacity = 0.5
        busView.layer.shadowRadius = 2.0
        
        userInformationLabel.layer.masksToBounds = true
        userInformationLabel.layer.cornerRadius = 5
        
        busInformationLabel.layer.masksToBounds = true
        busInformationLabel.layer.cornerRadius = 5
        
        userIDLabel.text = ticket.passenger.id.description
        userNameLabel.text = ticket.passenger.name
        userUsernameLabel.text = ticket.passenger.surname
        
        let hour = (bus.time.hour < 10) ? "0\(bus.time.hour)" : "\(bus.time.hour)"
        let minute = (bus.time.minute < 10) ? "0\(bus.time.minute)" : "\(bus.time.minute)"
        fromToLabel.text = "\(bus.from) - \(bus.to)"
        dateTimeLabel.text = "\(bus.date.day)/\(bus.date.mounth)/\(bus.date.year) - \(hour):\(minute)"
        seatsLabel.text = "\(ticket.seats.sorted())".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        
        buyButton.setTitle("Buy Ticket: \(ticket.seats.count * bus.fee) TL", for: .normal)
        buyButton.subtitleLabel?.text = "\(ticket.seats.count * bus.fee) TL"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Ticket Details"
    }
    
    @IBAction func buyTicketAciton(_ sender: Any) {
        buyOrReserveTicket(isBought: true)
    }
    
    @IBAction func reserveButtonAction(_ sender: Any) {
        buyOrReserveTicket(isBought: false)
    }
    
    private func buyOrReserveTicket(isBought: Bool){
        let alertView = UIAlertController(title: "Information", message: (isBought) ? "The purchase will be made successfully. Do you confirm?" : "Your ticket will be booked. Do you confirm?", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            
            let selectedBusIndex = Global.instance.buses.firstIndex { Bus in
                return self.bus.id == Bus.id
            }
            self.ticket.isBought = isBought // satın alındı
            Global.instance.buses[selectedBusIndex!].addTicket(ticket: self.ticket)
            
            let mainPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainController")
            self.navigationController?.pushViewController(mainPage, animated: true)
        }))
        alertView.addAction(UIAlertAction(title: "CANCEL", style: .destructive, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}
