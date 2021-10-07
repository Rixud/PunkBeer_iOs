//
//  PagTableViewCell.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import UIKit
import MarqueeLabel

class PagTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pagNumber: UILabel!
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var previousPage: UIButton!
    
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    
    var controller : SearchTableViewController?
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
    
    @IBAction func nextPagePress(_ sender: UIButton) {
        if let vc = controller {
            vc.nextPage()
        }
    }
    
    @IBAction func previousPage(_ sender: UIButton) {
        if let vc = controller {
            vc.previousPage()
        }
    }
    
    func updateUI() {

        if self.data != nil {
            if let dataCasted = data as? PagesModel {
                self.pagNumber.text = dataCasted.currentPage
                if let currentPage = Int(dataCasted.currentPage ?? "1") {
                    if currentPage > 1 {
                        previousPage.isHidden = false
                    } else {
                        previousPage.isHidden = true
                    }
                }
                
                if let currentCount = dataCasted.currentListCount, let perPage = dataCasted.perPage {
                    if currentCount < perPage || currentCount == 0{
                        nextPage.isHidden = true
                    }else {
                        nextPage.isHidden = false
                    }
                }
                
            }

        } else {
            previousPage.isHidden = true
            nextPage.isHidden = true
        }
    }
    
}
