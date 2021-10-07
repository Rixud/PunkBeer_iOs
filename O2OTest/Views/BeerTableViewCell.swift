//
//  BeerTableViewCell.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import UIKit
import MarqueeLabel

class BeerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var nameLabel: MarqueeLabel!
    @IBOutlet weak var tagLine: MarqueeLabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var ibuLabel: UILabel!
    
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    
    @IBOutlet weak var conceptWidth: NSLayoutConstraint!
    @IBOutlet weak var dateWidth: NSLayoutConstraint!
    
    var data: Codable? {
        didSet {
            self.updateUI()
        }
    }
    
    override required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           //commonInit()
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        
        if self.data != nil {
            if let dataCasted = data as? BeerModel {
                if let URL = URL(string: dataCasted.image_url ?? "") {
                    self.statusImage.kf.setImageWithRetry(with: URL)
                }
                
                
                self.abvLabel.text = "ALC \(dataCasted.abv?.formatterAmount() ?? "0.0") %Vol"
                self.ibuLabel.text = "\(dataCasted.ibu?.formatterAmount() ?? "0") IBU"
                self.tagLine.text = dataCasted.tagLine
                self.nameLabel.text = dataCasted.name
                self.nameLabel.labelize = true
                self.nameLabel.restartLabel()
                
            }

        }
    }
    
}
