//
//  ViewController.swift
//  week_4
//
//  Created by Bahattin Koç on 28.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var cities = [CityModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cities.append(CityModel(famousImg: "kebap", name: "Adana", famous: "Kebap"))
        cities.append(CityModel(famousImg: "köfte", name: "Adıyaman", famous: "Köfte"))
        cities.append(CityModel(famousImg: "kaymak", name: "Afyon", famous: "Kaymak"))
        
        // Register cell
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
//        cell.textLabel?.text = self.cities[indexPath.row].name
//        cell.detailTextLabel?.text = self.cities[indexPath.row].famous
//        cell.imageView?.image = UIImage(named: self.cities[indexPath.row].famousImg)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as? CityCell
        
        
//        cell.cityName.text = self.cities[indexPath.row].name
//        cell.famousName.text = self.cities[indexPath.row].famous
//        cell.famousImg.image = UIImage(named: self.cities[indexPath.row].famousImg)
        
        cell.configure(model: cities[indexPath.row])
        return cell
    }
    
    // Satıra tıklama
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row + 1)")
        print("\(cities[indexPath.row].name)")
        let alertController = UIAlertController(title: "\(cities[indexPath.row].name)", message: "\(cities[indexPath.row].famous)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
