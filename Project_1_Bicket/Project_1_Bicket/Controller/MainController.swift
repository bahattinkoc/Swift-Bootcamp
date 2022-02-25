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
    
    private func doShadowForView(view: UIView){
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.unselectedItemTintColor = .systemGray4
        
        // Label kalınlaştırma yapılıyor.
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 45)]
        let attributedString = NSMutableAttributedString(string:"bicket", attributes:attrs)
        let normalString = NSMutableAttributedString(string:".com")
        attributedString.append(normalString)
        brandLabel.attributedText = attributedString
        
        doShadowForView(view: fromToView)
        doShadowForView(view: dateTimeView)
        doShadowForView(view: welcomeLabel)
        welcomeLabel.layer.masksToBounds = true
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
        tabBarController?.tabBar.isHidden = true
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
        print(self.datePicker.date.formatted(date: .numeric, time: .omitted).localizedLowercase)
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
