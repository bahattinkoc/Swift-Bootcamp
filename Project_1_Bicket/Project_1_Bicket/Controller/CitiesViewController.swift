//
//  CitiesViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 15.02.2022.
//

import UIKit

protocol CityDelegate{
    func SendCity(city: String)
}

class CitiesViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cities = [CityModel]()
    var filteredCities = [CityModel]()
    var isFiltering: Bool = false
    var cityDelegate: CityDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Başlığı tıkladığımız label'a göre değiştiriyoruz
        titleLabel.text = UserDefaults.standard.string(forKey: "CitiesViewTitle")
        
        // Sayfayı tekrar açtığımızda eski aramaları silip tabloyu sıfırlıyoruz
        isFiltering = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.path(forResource: "cities", ofType: "json") else { return }
        let citiesList = try? JSONDecoder().decode([CityModel].self, from: Data(contentsOf: URL(fileURLWithPath: path)))
        guard let cities = citiesList else { return }
        self.cities = cities
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        if self.cities.count == 0{
            setHidden(imageViewHidden: false, tableViewHidden: true)
        } else {
            setHidden(imageViewHidden: true, tableViewHidden: false)
        }
    }
    
    func setHidden(imageViewHidden: Bool, tableViewHidden: Bool){
        self.imageView.isHidden = imageViewHidden
        self.tableView.isHidden = tableViewHidden
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltering) ? filteredCities.count : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell")
        
        let city: CityModel
        city = (isFiltering) ? filteredCities[indexPath.row] : cities[indexPath.row]
        
        cell?.textLabel?.text = city.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityName = (isFiltering) ? self.filteredCities[indexPath.row].name : self.cities[indexPath.row].name
        self.cityDelegate?.SendCity(city: cityName!)
        dismiss(animated: true, completion: nil)
    }
}

extension CitiesViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        setHidden(imageViewHidden: true, tableViewHidden: false)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            filteredCities = cities.filter({ (city:CityModel) -> Bool in
                return city.name!.localizedLowercase.contains(searchText.localizedLowercase)
            })
            if filteredCities.count == 0{
                setHidden(imageViewHidden: false, tableViewHidden: true)
            } else {
                setHidden(imageViewHidden: true, tableViewHidden: false)
            }
            isFiltering = true
        } else {
            setHidden(imageViewHidden: true, tableViewHidden: false)
            isFiltering = false
        }
        
        tableView.reloadData()
    }
}
