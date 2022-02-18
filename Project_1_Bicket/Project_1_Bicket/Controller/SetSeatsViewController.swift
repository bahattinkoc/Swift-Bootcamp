//
//  SetSeatsViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 16.02.2022.
//

import UIKit

class SetSeatsViewController: UIViewController {

    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var choosenSeatsLabel: UILabel!
    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var seatSelectionLabel: UILabel!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var fillLabel: UILabel!
    @IBOutlet weak var userInformationLabel: UILabel!
    @IBOutlet weak var seatContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passengerView: UIView!
    @IBOutlet weak var seatsView: UIView!
    
    var bus: Bus = Global.instance.selectedBus!
    var selectedSeats = [Int]()
    
    override func viewWillAppear(_ animated: Bool) {
        passengerView.layer.cornerRadius = 10
        passengerView.layer.shadowColor = UIColor.lightGray.cgColor
        passengerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        passengerView.layer.shadowOpacity = 0.5
        passengerView.layer.shadowRadius = 2.0
        
        seatsView.layer.cornerRadius = 10
        seatsView.layer.shadowColor = UIColor.lightGray.cgColor
        seatsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        seatsView.layer.shadowOpacity = 0.5
        seatsView.layer.shadowRadius = 2.0
        
        seatContentView.layer.cornerRadius = 10
        scrollView.layer.cornerRadius = 10
        
        userInformationLabel.layer.masksToBounds = true
        userInformationLabel.layer.cornerRadius = 5
        
        seatSelectionLabel.layer.masksToBounds = true
        seatSelectionLabel.layer.cornerRadius = 5
        
        emptyLabel.layer.masksToBounds = true
        emptyLabel.layer.cornerRadius = 5
        emptyLabel.layer.borderColor = UIColor.gray.cgColor
        emptyLabel.layer.borderWidth = 0.5
        
        fillLabel.layer.masksToBounds = true
        fillLabel.layer.cornerRadius = 5
        
        selectedLabel.layer.masksToBounds = true
        selectedLabel.layer.cornerRadius = 5
        
        // Global.instance.selectedBus!.addTicket(ticket: Ticket(passenger: Passenger(name: "Bahattin", surname: "Koç", id: 58), date: Global.instance.selectedBus!.date, time: Global.instance.selectedBus!.time, seats: [1,5,7]))
        
        loadSeats()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Set Seats"
    }
    
    private func loadSeats(){
        var x = 115 // yatay
        var y = 10 // dikey
        var index = 1
        var verticalCounter = 1 // dikey olarak eklenilen her koltuk için bir artır ve dikey hizalamayı artır. 5 olunca yatay hizlamayı artır
        
        while index <= 45{
            if verticalCounter != 3 || index == 43{ // Orta koltuk değilse
                let seat: UILabel = Seat(text: index.description)
                seat.frame = CGRect(x: x, y: y, width: 50, height: 50)
                scrollView.addSubview(seat)
                
                verticalCounter += 1
                y += 55
                
                if verticalCounter == 6{
                    verticalCounter = 1
                    
                    y = 10
                    x = x + 55
                }
                
                index += 1
                if index == 21 || index == 23{ // orta kapı kısmını boş bırak
                    verticalCounter = 3
                    y += 2 * 55
                }
            } else {
                y += 55 // ortaya boş alan ekle
                verticalCounter += 1
            }
        }
    }
    
    private func Seat(text: String) -> UILabel{
        let seat = UILabel()
        seat.backgroundColor = .white
        seat.layer.borderColor = UIColor.gray.cgColor
        seat.layer.borderWidth = 0.5
        seat.layer.cornerRadius = 10
        seat.layer.masksToBounds = true
        seat.textAlignment = .center
        seat.text = text
        if (bus.seats.contains(Int(text) ?? 0) != false){ // Koltuk daha önce alınmış ise kırmızıya boya ve kullanıcı etkileşimini kes
            seat.backgroundColor = .systemRed
        } else{
            if selectedSeats.contains(Int(text) ?? 0) != false{ // confirm edilip tekrar geri basılırsa daha önceden seçilmiş koltukları tekrar boya
                seat.backgroundColor = .systemGreen
            }
            
            seat.isUserInteractionEnabled = true
            seat.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSeat(recognizer:))))
        }
        return seat
    }
    
    @objc private func tapSeat(recognizer: UITapGestureRecognizer){
        guard let seat = recognizer.view as? UILabel else { return }
        if seat.backgroundColor == .white{ // koltuk seçilmiş ise
            if selectedSeats.count >= 5 {
                // Kullanıcıya hata bildir
                let alertDialog = UIAlertController(title: "Warning", message: "You can choose up to 5 seats.", preferredStyle: .alert)
                alertDialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertDialog, animated: true, completion: nil)
            } else {
                selectedSeats.append(Int(seat.text!) ?? 0)
                seat.backgroundColor = .systemGreen
            }
        } else { // koltuktan vaz geçilmiş ise
            seat.backgroundColor = .white
            selectedSeats.remove(at: selectedSeats.firstIndex(of: Int(seat.text!)!)!)
        }
        
        if selectedSeats.count == 0{
            confirmButton.isEnabled = false
            choosenSeatsLabel.text = "* Please choose a seat(s)"
        } else{
            confirmButton.isEnabled = true
            choosenSeatsLabel.text = "Selected seat(s): \(selectedSeats.sorted())".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        }
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        let id = idTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let surname = surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if id != "" && name != "" && surname != ""{
            Global.instance.selectedTicket = Ticket(passenger: Passenger(name: name!, surname: surname!, id: Int(id!) ?? 0), date: bus.date, time: bus.time, seats: selectedSeats)
            let detailPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TicketDetailViewController")
            navigationController?.pushViewController(detailPage, animated: true)
        } else {
            let alertView = UIAlertController(title: "Warning", message: "Please fill the blanks!", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertView, animated: true, completion: nil)
        }
    }
}
