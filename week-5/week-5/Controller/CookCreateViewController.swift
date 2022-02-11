//
//  CookCreateViewController.swift
//  week-5
//
//  Created by Bahattin Koç on 5.02.2022.
//

import UIKit

class CookCreateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var cookImage: UIImageView!
    @IBOutlet weak var cookNameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cookImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        cookImage.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cookImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cookCreateAction(_ sender: Any) {
        /*guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newCook = NSEntityDescription.insertNewObject(forEntityName: "Cooks", into: context)
        
        newCook.setValue(cookNameLabel.text, forKey: "name") // Veritabanındaki name
        let imageData = cookImage.image?.jpegData(compressionQuality: 0.5)
        newCook.setValue(imageData, forKey: "image") // veritabanındaki image
        
        do{
            try context.save()
        } catch {
            print("Veri kaydedilemedi!")
        }*/
        
        self.navigationController?.popViewController(animated: true)
    }
}
