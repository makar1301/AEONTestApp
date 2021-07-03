//
//  PaymentsViewController.swift
//  AEONTestApp
//
//  Created by Nikita Makarov on 02.07.2021.
//

import UIKit
import Alamofire

class PaymentsViewController: UIViewController {
    
    // MARK: - Internal Vars & Lets
    
    private let cellIdentifire = "PaymentsCell"
    let paymentsLink = "http://82.202.204.94/api-test/payments?token="
    let headers: HTTPHeaders = ["app-key" : "12345", "v" : "1"]
    var token = Persistance.shared.userToken
    var paymentsArray: Payments?
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getPayments()
        setTableView()
    }
    
    
    // MARK: - IBActions
    @IBAction func logOutButton(_ sender: Any) {
            Persistance.shared.userToken = nil
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Settings of Table
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PaymentsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifire)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.reloadData()
    }
    
    
    private func getPayments() {
        let url = paymentsLink + token!
        AF.request(url,
                   headers: headers)
                   .response { response in

            if let jsonData = try? response.result.get() {
            do {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                let decoder =  JSONDecoder()
                let payments = try decoder.decode(Payments.self, from: jsonData)
                
                DispatchQueue.main.async {
                    self.paymentsArray = payments
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print(error)
            }
            }
        }
    }
}


extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return paymentsArray?.response.count ?? 0

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! PaymentsTableViewCell
        guard let item = paymentsArray?.response[indexPath.row] else { return cell}
        
        cell.setupCell(data: item)
        
        return cell
    }
    
    
}
