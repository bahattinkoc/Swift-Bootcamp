//
//  TicketDetailViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 18.02.2022.
//

import UIKit
import CoreData

class TicketDetailViewController: UIViewController {

    @IBOutlet weak var longToLabel: UILabel!
    @IBOutlet weak var shortToLabel: UILabel!
    @IBOutlet weak var shortFromLabel: UILabel!
    @IBOutlet weak var longFromLabel: UILabel!
    @IBOutlet weak var pnrNoLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userUsernameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var barcodeImage: UIImageView!
    
    var ticketOnDB: NSManagedObject?
    
    let ticket = Global.instance.selectedTicket!
    let bus = Global.instance.selectedBus!
    var isPnr: Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
        
        isPnr =  UserDefaults.standard.value(forKey: "isPnr") as? Bool
        
        userIDLabel.text = ticket.passenger.id.description
        userNameLabel.text = ticket.passenger.name
        userUsernameLabel.text = ticket.passenger.surname
        
        let hour = (bus.time.hour < 10) ? "0\(bus.time.hour)" : "\(bus.time.hour)"
        let minute = (bus.time.minute < 10) ? "0\(bus.time.minute)" : "\(bus.time.minute)"

        shortFromLabel.text = bus.from.prefix(3).description
        shortToLabel.text = bus.to.prefix(3).description
        longFromLabel.text = bus.from
        longToLabel.text = bus.to
        dateTimeLabel.text = "\(bus.date.day)/\(bus.date.mounth)/\(bus.date.year) - \(hour):\(minute)"
        seatsLabel.text = "\(ticket.seats.sorted())".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        
        priceLabel.text = "\(ticket.seats.count * bus.fee) TL"
        
        pnrNoLabel.text = ticket.pnrNo
        
        if isPnr! {
            reserveButton.setTitle("Delete Ticket", for: .normal)
            
            let ticketList = Global.instance.getArrayFromDB(entityName: "TicketDB") as! [NSManagedObject]
            for ticketItem in ticketList{
                if ticketItem.value(forKey: "pnrNo") as? String == self.pnrNoLabel.text{
                    self.ticketOnDB = ticketItem
                }
            }
        }
        
        if ticket.isBought == true{
            reserveButton.isHidden = true
            buyButton.isHidden = true
        }
        
        barcodeImage.image = generateQRCode(from: ticket.pnrNo)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    @IBAction func copyButton(_ sender: Any) {
        UIPasteboard.general.string = pnrNoLabel.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Ticket Details"
    }
    
    @IBAction func buyTicketAciton(_ sender: Any) {
        buyOrReserveTicket(isBought: true)
    }
    
    @IBAction func reserveButtonAction(_ sender: Any) {
        if isPnr!{
            let alertView = UIAlertController(title: "Information", message: "Are you sure you want to delete the ticket?", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                do {
                    (Global.instance.context as! NSManagedObjectContext).delete(self.ticketOnDB!)
                    try (Global.instance.context as! NSManagedObjectContext).save()
                    Global.instance.loadDB()
                    let checkPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CheckTicketViewController")
                    self.navigationController?.pushViewController(checkPage, animated: true)
                } catch let error as NSError {
                    print(error)
                }
            }))
            alertView.addAction(UIAlertAction(title: "CANCEL", style: .destructive, handler: nil))
            present(alertView, animated: true, completion: nil)
            
        } else {
            buyOrReserveTicket(isBought: false)
        }
    }
    
    private func buyOrReserveTicket(isBought: Bool){
        let alertView = UIAlertController(title: "Information", message: (isBought) ? "The purchase will be made successfully. Do you confirm?" : "Your ticket will be booked. Do you confirm?", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
        
            if self.isPnr! {
                self.ticketOnDB?.setValue(true, forKey: "isBought")
                do {
                    try (Global.instance.context as! NSManagedObjectContext).save()
                } catch let error as NSError {
                    print(error)
                }
                
                Global.instance.loadDB()
                
                let checkPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CheckTicketViewController")
                self.navigationController?.pushViewController(checkPage, animated: true)

            } else {
                let selectedBusIndex = Global.instance.buses.firstIndex { Bus in
                    return self.bus.id == Bus.id
                }
                self.ticket.isBought = isBought // satın alındı
                Global.instance.buses[selectedBusIndex!].addTicket(ticket: self.ticket)
                
                Global.instance.addTicket(busId: self.bus.id, pnrNo: self.ticket.pnrNo, date: self.bus.date.printDate(), time: self.bus.time.printTime(), isBought: isBought, seats: self.ticket.seats, passenger: self.ticket.passenger)
                
                let mainPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainController")
                self.navigationController?.pushViewController(mainPage, animated: true)
            }
        }))
        alertView.addAction(UIAlertAction(title: "CANCEL", style: .destructive, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}
