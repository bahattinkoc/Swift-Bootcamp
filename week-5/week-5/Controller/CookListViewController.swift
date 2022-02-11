//
//  CookListViewController.swift
//  week-5
//
//  Created by Bahattin Koç on 5.02.2022.
//

import UIKit

class CookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cookNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getCooks()
    }
    
    private func getCooks(){
        /*guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cooks")
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    guard let name = result.value(forKey: "name") as? String else {return}
                    cookNames.append(name)
                }
                self.tableView.reloadData()
            } else {
                // TODO: Hata verilebilir
            }
        } catch {
            print("Veri çekilemedi")
        }*/
    }
}

extension CookListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cookNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cookCell")
        cell?.textLabel?.text = cookNames[indexPath.row]
        return cell!
    }
}
