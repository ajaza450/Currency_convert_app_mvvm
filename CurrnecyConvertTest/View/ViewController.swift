//
//  ViewController.swift
//  CurrnecyConvertTest
//
//  Created by EZAZ AHAMD on 03/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField:UITextField!
    @IBOutlet weak var selectCurrencyCode:UIButton!
    @IBOutlet weak var tableView:UITableView!
    
   
    //MARK: -  Setup Toolbar
  lazy var toolBar: UIToolbar = {
        var toolBar = UIToolbar()
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
      return toolBar
    }()
    
    //MARK: - Setup UIPickerView
   lazy var picker : UIPickerView = {
        let picker = UIPickerView.init()
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        return picker
    }()
    
    let viewModel = CurrencyConverterViewModel()
    var selected_Index : Int?
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        observer()
    }

    //MARK: - Default Configuration
    
    func configuration() {
        viewModel.load_saved_data()
       textField.delegate = self
       let tapRecognizer = UITapGestureRecognizer()
       tapRecognizer.addTarget(self, action: #selector(didTapView))
       self.view.addGestureRecognizer(tapRecognizer)
   }
    
    
    //MARK: - Observer For Handel Events
    
    func observer(){
        viewModel.eventHandler = {[weak self] event in
            switch event{
            case .currencies_converted:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .error_fatchCurrencies(let message):
                ///Error
                _ = self?.showAlertWithTitleMessageAndButtonTextWithHandling(title: "", message: message, buttonTitles: ["OK"], completion: [{ _ in
                    self?.viewModel.fetchCurrencies()
                }])
            case .error(_):
                break
                
            }
        }
    }
    
    //MARK: - Load Picker View
    
    @IBAction func clickOnPicker(_ sender: UIButton) {
        textField.resignFirstResponder()
        picker.delegate = self
        picker.dataSource = self
        self.view.addSubview(picker)
        self.view.addSubview(toolBar)
        
    }
    
    
    //MARK: - Select Currency Event
    
    @objc func onDoneButtonTapped() {
        selected_Index = picker.selectedRow(inComponent: 0)
        guard let index = selected_Index else{return}
        selectCurrencyCode.setTitle(viewModel.currencies[index].name, for: .normal)
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        if let text = textField.text, let amount = Double(text) {
            convertamount(amount, index)
        }
       
    }
    
    //MARK: -  Convert amount
     func convertamount(_ amount: Double, _ index: Int) {
        viewModel.convert(amount: amount, fromCurrency: viewModel.currencies[index], toCurrencies: viewModel.currencies)
    }
    
    
    //MARK: -  Keyboard dismiss
    @objc func didTapView(){
      self.view.endEditing(true)
    }

    
    
}


//MARK: - TextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let amount = Double(text), let index = selected_Index {
            convertamount(amount, index)
        }
    }
}

//MARK: - PickerViewDelegate & PickerViewDataSource

extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return viewModel.currencies.count
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return viewModel.currencies[row].name
       }
            
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.conversions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else{return UITableViewCell()}
        let conversion1 = viewModel.conversions[indexPath.row]
        cell.textLabel?.text = "\(conversion1.currency.name): \(conversion1.amount!)"
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
}




