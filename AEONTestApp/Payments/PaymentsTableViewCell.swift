//
//  PaymentsTableViewCell.swift
//  AEONTestApp
//
//  Created by Nikita Makarov on 02.07.2021.
//

import UIKit

class PaymentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var createdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(data: Response) {
        
        self.descriptionLabel.text = data.desc

        switch data.amount {
        case .string(let x) : self.amountLabel.text = "\(x)"
        case .double(let x) : self.amountLabel.text = "\(x)"
        case .integer(let x) : self.amountLabel.text = "\(x)"
        }
        
        self.currencyLabel.text = data.currency
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        let theDate = formatter.date(from: "\(data.created)")
        let newDateFormater = DateFormatter()
        newDateFormater.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let date = newDateFormater.string(from: theDate!)
        self.createdLabel.text = "\(date)"
        
        
    }
    
}
