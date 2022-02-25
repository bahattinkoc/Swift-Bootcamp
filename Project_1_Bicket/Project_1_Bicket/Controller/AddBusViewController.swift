//
//  AboutViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 22.02.2022.
//

import UIKit

class AddBusViewController: UIViewController {

    @IBOutlet weak var fromToView: UIView!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var feeView: UIView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var feeTextField: UITextField!
    
    var isFrom: Bool = true
    let citiesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitiesViewController") as! CitiesViewController
    private var customView: UIView!
    private var msgLabel: UILabel!
    
    @objc private func fromGesture(){
        UserDefaults.standard.set("From", forKey: "CitiesViewTitle")
        isFrom = true
        present(citiesVC, animated: true, completion: nil)
    }
    
    @objc private func toGesture(){
        UserDefaults.standard.set("To", forKey: "CitiesViewTitle")
        isFrom = false
        present(citiesVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCustomView()
        customView.isHidden = true
        
        citiesVC.cityDelegate = self
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 45)]
        let attributedString = NSMutableAttributedString(string:"bicket", attributes:attrs)
        let normalString = NSMutableAttributedString(string:".com")
        attributedString.append(normalString)
        brandLabel.attributedText = attributedString
        
        doShadowForView(view: fromToView)
        doShadowForView(view: dateTimeView)
        doShadowForView(view: welcomeLabel)
        doShadowForView(view: feeView)
        welcomeLabel.layer.masksToBounds = true
        
        datePicker.minimumDate = .now
        
        let tapFrom = UITapGestureRecognizer(target: self, action: #selector(fromGesture))
        fromLabel.isUserInteractionEnabled = true
        fromLabel.addGestureRecognizer(tapFrom)
        let tapTo = UITapGestureRecognizer(target: self, action: #selector(toGesture))
        toLabel.isUserInteractionEnabled = true
        toLabel.addGestureRecognizer(tapTo)
    }
    
    private func doShadowForView(view: UIView){
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.0
    }
    
    @IBAction func todayButtonAction(_ sender: Any) {
        datePicker.date = .now
    }
    
    @IBAction func tomorrowButtonAction(_ sender: Any) {
        datePicker.date = .now + (60 * 60 * 24)
    }
    
    @IBAction func addBusButtonAction(_ sender: Any) {
        let dateStr = datePicker.date.formatted(date: .numeric, time: .omitted).localizedLowercase // ay/gün/yil
        
        let timeStr = datePicker.date.description.split(separator: " ")[1].split(separator: ":") // 17:11:33
        
        guard fromLabel.text! != "ANY" else {
            showCustomView(backgroundColor: .systemYellow, msg: "Please select from!")
            return
        }
        
        guard toLabel.text! != "ANY" else {
            showCustomView(backgroundColor: .systemYellow, msg: "Please select to!")
            return
        }
        
        guard Int(feeTextField.text!) ?? 0 > 0 else {
            showCustomView(backgroundColor: .systemYellow, msg: "Please fill fee!")
            return
        }
        
        guard fromLabel.text != toLabel.text else {
            showCustomView(backgroundColor: .systemYellow, msg: "Please change from or to!")
            return
        }
        
        showCustomView(backgroundColor: .systemGreen, msg: "OK")
        
        Global.instance.addBus(from: fromLabel.text!, to: toLabel.text!, date: dateStr, time: "\(timeStr[0]):\(timeStr[1])", fee: Int(feeTextField.text!) ?? 0)
        
        fromLabel.text = "ANY"
        toLabel.text = "ANY"
        feeTextField.text = ""
    }
    
    private func loadCustomView(){
        customView = UIView(frame: CGRect(x: 10, y: 50, width: self.view.bounds.width - 20, height: 50))
        view.addSubview(customView)
        
        msgLabel = UILabel(frame: CGRect(x: 0, y: 0, width: customView.bounds.width, height: 50))
        msgLabel.textAlignment = .center
        msgLabel.textColor = .systemBackground
        
        customView.addSubview(msgLabel)
        
        doShadowForView(view: customView)
    }
    
    @objc private func hideCustomView(){
        customView.isHidden = true
    }
    
    private func showCustomView(backgroundColor: UIColor, msg: String){
        customView.isHidden = false
        customView.backgroundColor = backgroundColor
        msgLabel.text = msg
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.customView.isHidden = true
        }
    }
}

extension AddBusViewController: CityDelegate{
    func SendCity(city: String) {
        if isFrom{
            fromLabel.text = city
        } else {
            toLabel.text = city
        }
    }
}
