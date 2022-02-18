//
//  ViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 10.02.2022.
//

/*
 * Sağ üstte + butonu olacak
 * Ortada bir table view ve search bar olacak
 * TableView'ın cell'eri özel olabilir?
 */

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var fromToView: UIView!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var isFrom: Bool = true
    let citiesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitiesViewController") as! CitiesViewController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        // Label kalınlaştırma yapılıyor.
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 45)]
        let attributedString = NSMutableAttributedString(string:"bicket", attributes:attrs)
        let normalString = NSMutableAttributedString(string:".com")
        attributedString.append(normalString)
        brandLabel.attributedText = attributedString
        
        fromToView.layer.cornerRadius = 10
        fromToView.layer.shadowColor = UIColor.lightGray.cgColor
        fromToView.layer.shadowOffset = CGSize(width: 0, height: 0)
        fromToView.layer.shadowOpacity = 0.5
        fromToView.layer.shadowRadius = 2.0
        
        dateTimeView.layer.cornerRadius = 10
        dateTimeView.layer.shadowColor = UIColor.lightGray.cgColor
        dateTimeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        dateTimeView.layer.shadowOpacity = 0.5
        dateTimeView.layer.shadowRadius = 2.0
        
        welcomeLabel.layer.cornerRadius = 10
        welcomeLabel.layer.masksToBounds = true
        welcomeLabel.layer.shadowColor = UIColor.lightGray.cgColor
        welcomeLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        welcomeLabel.layer.shadowOpacity = 0.5
        welcomeLabel.layer.shadowRadius = 2.0
        
        Global.instance.buses[0].autoFill(limit: 45)
        Global.instance.buses[1].autoFill(limit: 20)
        Global.instance.buses[2].autoFill(limit: 10)
        Global.instance.buses[3].autoFill(limit: 45)
        Global.instance.buses[4].autoFill(limit: 40)
        Global.instance.buses[5].autoFill(limit: 23)
        Global.instance.buses[6].autoFill(limit: 45)
        Global.instance.buses[8].autoFill(limit: 34)
        Global.instance.buses[17].autoFill(limit: 34)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        citiesVC.cityDelegate = self
        
        // Uygulama ilk kez mi açılıyor? Kontrol et.
        if UserDefaults.standard.object(forKey: "PassOnboard") == nil {
            let onboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootOnboard")
            onboard.modalPresentationStyle = .fullScreen
            present(onboard, animated: true, completion: nil)
        }
        
        let tapFrom = UITapGestureRecognizer(target: self, action: #selector(tapFromAction))
        fromLabel.addGestureRecognizer(tapFrom)
        
        let tapTo = UITapGestureRecognizer(target: self, action: #selector(tapToAction))
        toLabel.addGestureRecognizer(tapTo)
    }
    
    @objc func tapFromAction(){
        UserDefaults.standard.set("From", forKey: "CitiesViewTitle")
        isFrom = true
        present(citiesVC, animated: true, completion: nil)
    }
    
    @objc func tapToAction(){
        UserDefaults.standard.set("To", forKey: "CitiesViewTitle")
        isFrom = false
        present(citiesVC, animated: true, completion: nil)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let busVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowBusViewController")
        busVC.modalPresentationStyle = .fullScreen
        UserDefaults.standard.set(self.fromLabel.text, forKey: "from")
        UserDefaults.standard.set(self.toLabel.text, forKey: "to")
        UserDefaults.standard.set(self.datePicker.date.formatted(date: .numeric, time: .omitted).localizedLowercase, forKey: "date")
        navigationController?.pushViewController(busVC, animated: true)
        //present(busVC, animated: true, completion: nil)
    }
    
    @IBAction func todayButton(_ sender: Any) {
        datePicker.date = .now
    }
    
    @IBAction func tomorrowButton(_ sender: Any) {
        datePicker.date = .now + (24 * 60 * 60)
    }
}

extension MainController: CityDelegate{
    func SendCity(city: String) {
        if isFrom{
            fromLabel.text = city
        } else {
            toLabel.text = city
        }
    }
}
