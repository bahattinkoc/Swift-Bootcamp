//
//  SearchBarViewController.swift
//  week5Projects
//
//  Created by Bahattin Koç on 9.02.2022.
//

import UIKit

class SearchBarViewController: UIViewController {

    @IBOutlet weak var notFoundImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var symbols = [Symbol]()
    var filteredSymbols = [Symbol]()
    var isFiltering: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        searchBar.delegate = self
        
        guard let symbolsJSON = URL(string: "https://api.binance.com/api/v3/ticker/24hr") else { return }
        let symbolList = try? JSONDecoder().decode([Symbol].self, from: Data(contentsOf: symbolsJSON))
        guard let symbols = symbolList else { return }
        self.symbols = symbols
        
        if self.symbols.count == 0{
            notFoundImage.isHidden = false
            tableView.isHidden = true
        } else {
            notFoundImage.isHidden = true
            tableView.isHidden = false
        }
    }
}

extension SearchBarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltering) ? filteredSymbols.count : symbols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "symbolCell")
        
        let symbol: Symbol
        if isFiltering{
            symbol = filteredSymbols[indexPath.row]
        } else {
            symbol = symbols[indexPath.row]
        }
        
        cell?.textLabel?.text = symbol.symbol
        cell?.detailTextLabel?.text = symbol.lastPrice
        return cell!
    }
}

extension SearchBarViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        notFoundImage.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            filteredSymbols = symbols.filter({ (symbol:Symbol) -> Bool in
                return symbol.symbol!.lowercased().contains(searchText.lowercased())
            })
            if filteredSymbols.count == 0{
                notFoundImage.isHidden = false
                tableView.isHidden = true
            } else {
                notFoundImage.isHidden = true
                tableView.isHidden = false
            }
            isFiltering = true
        } else {
            notFoundImage.isHidden = true
            tableView.isHidden = false
            isFiltering = false
        }
        tableView.reloadData()
    }
}
