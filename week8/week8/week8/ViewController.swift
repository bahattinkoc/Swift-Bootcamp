//
//  ViewController.swift
//  week8
//
//  Created by Bahattin Koç on 19.02.2022.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    var counter = 0
    var users = [User]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSnapshot()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
//        let user = User(userId: "3", name: "Can")
//        self.ref.child("users").child(user.userId ?? "").setValue(["username": user.name])
        
        print(users.count)
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        let alertView = UIAlertController(title: "Ekle", message: "Kullanıcı Ekle", preferredStyle: .alert)
        alertView.addTextField { textField in }
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            let user = User(userId: "\(self.counter)", name: "\(alertView.textFields![0].text ?? "")")
            self.ref.child("users").child(user.userId ?? "").setValue(["username": user.name])
            self.counter += 1
            self.getSnapshot()
        }))
        
        present(alertView, animated: true, completion: nil)
        
        // ref.child("users").child("1").child("username").removeValue()
        
        // getSnapshot()
    }
    
    func getSnapshot(){
        self.users.removeAll()
        let ref = Database.database().reference().child("users")
            ref.observeSingleEvent(of: .value, with: { (snap : DataSnapshot)  in
                for child in snap.children {
                    let key = (child as AnyObject).key as String
                    self.getData(userId: key)
                }
            }) { (err: Error) in
                print("\(err.localizedDescription)")
            }
    }
    
    func getData(userId: String){
        ref.child("users/\(userId)/username").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            let userName = snapshot.value as? String ?? "Unknown";
            
            self.users.append(User(userId: userId, name: userName ))
            print("username: ", self.users)
            self.tableView.reloadData()
        });
    }
}

struct User {
    let userId: String?
    let name: String?
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        //print("index: ", indexPath.row)
//        ref.child("users").child("\(indexPath.row + 2)").child("username").removeValue()
//
//        getSnapshot()
//    }
}
