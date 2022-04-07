//
//  NewStockViewController.swift
//  MVVM
//
//  Created by Bahattin Koç on 26.03.2022.
//

import UIKit

class NewStockViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var stockNameTextField: UITextField!
    @IBOutlet weak var stockCountTextField: UITextField!
    @IBOutlet weak var stockPriceTextfFeld: UITextField!
    @IBOutlet weak var comissionTextField: UITextField!
    
    private var stocks: [StockListData]?
    private var viewModel: NewStockViewModelProtocol = NewStockViewModel()
    private let stockPickerView = UIPickerView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getStockList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        styleUI()
    }
    
    private func styleUI() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        toolbar.setItems([doneBtn], animated: true)
        
        stockNameTextField.inputView = stockPickerView
        stockPickerView.delegate = self // viewModel de olabilir miydi
        stockPickerView.dataSource = self // viewModel de olabilir miydi
        stockNameTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked() {
        // self.stockNameTextField.text = stocks?[stockPickerView.selectedRow(inComponent: 0)].kod
        self.view.endEditing(true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let newStock = NewStockModel()
        let date = dateTextField.text
        let name = stockNameTextField.text
        let count = Double(stockCountTextField.text ?? "") ?? 0
        let price = Double(stockPriceTextfFeld.text ?? "") ?? 0
        let commission = Double(comissionTextField.text ?? "") ?? 0
        let totalPrice = newStock.totalPrice ?? 0
        
        var newStockModel = NewStockModel(date: date, name: name, count: count, price: price, commission: commission, totalPrice: totalPrice)
        viewModel.saveNewStock(newStockModel: &newStockModel)
    }
}

extension NewStockViewController: NewStockViewMdoelDelegate {
    func clearFields() {
        // MARK: Aler ile sonucu gösterip
        dateTextField.text = ""
        stockNameTextField.text = ""
        stockCountTextField.text = ""
        stockPriceTextfFeld.text = ""
        comissionTextField.text = ""
    
    }
    
    func updateStockList(stocks: [StockListData]) {
        self.stocks = stocks
    }
}

extension NewStockViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfItems ?? 0 // self.stocks?.count ?? 0 // viewModel.numberOfItems
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.stocks?[row].kod // viewModelden alınamaz mıydı.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stockNameTextField.text = stocks?[row].kod // viewModeldan mı gelmeli
    }
}
