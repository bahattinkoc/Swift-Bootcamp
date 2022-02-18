//
//  BuyTicketViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 15.02.2022.
//

import UIKit

class ShowBusViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var filteredBus = [Bus]()
    var from: String?
    var to: String?
    var date: [String]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        from = UserDefaults.standard.string(forKey: "from")
        to = UserDefaults.standard.string(forKey: "to")
        date = UserDefaults.standard.string(forKey: "date")?.components(separatedBy: "/")
        
        for item in Global.instance.buses{
            if ((item.from.localizedLowercase == from?.localizedLowercase && from != "ANY") || from == "ANY") && ((item.to.localizedLowercase == to?.localizedLowercase && to != "ANY") || to == "ANY") && item.date.mounth.description == date![0] && item.date.day.description == date![1] && item.date.year.description == date![2]{
                filteredBus.append(item)
            }
        }
        
        if self.filteredBus.count == 0{
            setHidden(imageViewHidden: false, tableViewHidden: true)
        } else {
            setHidden(imageViewHidden: true, tableViewHidden: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        title = "Bus Schedules"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "BusCell", bundle: nil), forCellReuseIdentifier: "busCell")
    }
    
    private func setHidden(imageViewHidden: Bool, tableViewHidden: Bool){
        self.imageView.isHidden = imageViewHidden
        self.tableView.isHidden = tableViewHidden
    }
}

extension ShowBusViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "busCell") as! BusCell
        cell.configure(model: filteredBus[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //UserDefaults.standard.set(filteredBus[indexPath.row].id, forKey: "busId")
        
        if filteredBus[indexPath.row].seats.count >= 45{
            let alertView = UIAlertController(title: "Warning", message: "There are no vacancies on the bus you have chosen.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertView, animated: true, completion: nil)
        } else {
            Global.instance.selectedBus = filteredBus[indexPath.row]
            let seatPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetSeatsViewController")
            navigationController?.pushViewController(seatPage, animated: true)
        }
    }
}
