//
//  ViewController.swift
//  Testigmbi
//
//  Created by EZAZ AHAMD on 09/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    
    var bookViewModel = BookingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configuration()
    }
    
    
    func configuration(){
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "BookTableViewCell")
        bookViewModel.Api(param: ["date": "2023-02-07","time":"10.30","person":"2","latitude":"53.798407","longitude":"-1.548248"])
        observer()
    }
    
    
    func observer(){
        bookViewModel.eventHandler = {[weak self] event in
            switch event{
            case .dataLoaded:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .error: break
                ///Error
            }
        }
    }
    
}



extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookViewModel.data.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else{
            return UITableViewCell()
        }
        cell.loadData = bookViewModel.data[indexPath.row]
        return cell
    }
    
    
}


