//
//  CampaignViewController.swift
//  week8
//
//  Created by Bahattin Koç on 26.02.2022.
//

import UIKit

class CampaignViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var campaingRequest = CampaignRequest()
    
    var campaigns = [Campaign]() {
        didSet{ // tablo değiştiğinde tetiklenir
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setErrorAlertView(controllerMsg: String) -> UIAlertController{
        let alertView = UIAlertController(title: "Error", message: controllerMsg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.campaingRequest.getCampaign { result in
//            do {
//                self.campaigns = try result.get()
//            } catch let error as Error {
//                print("Kontrol Catch: ", error)
//            }
            
            switch result{
                
            case .success(let campaigns):
                DispatchQueue.main.async {
                    self.campaigns = campaigns
                }
            case .failure(let error):
                print(error.localizedDescription)
                
                switch error{
                    
                case .canNotProcessData:
                    DispatchQueue.main.async {
                        self.present(self.setErrorAlertView(controllerMsg: "Cannat process the data!"), animated: true, completion: nil)
                    }
                    
                case .noDataAvaible:
                    DispatchQueue.main.async {
                        self.present(self.setErrorAlertView(controllerMsg: "Data no avaible!"), animated: true, completion: nil)
                    }
                }
                
            }
        }
    }
}

extension CampaignViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.campaigns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "campaignCell", for: indexPath)
        cell.textLabel?.text = self.campaigns[indexPath.row].baslik
        return cell
    }
}
