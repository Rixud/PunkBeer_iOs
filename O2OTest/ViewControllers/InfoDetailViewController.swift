//
//  InfoDetailViewController.swift
//
//  Created by Luis Guerra on 10/6/21.
//

import UIKit

class InfoDetailViewController: UIViewController {
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    var tittleString: String?
    var ingredientsInfo: IngredientModel?
    var brewerTip: String?
    var pairingInfo: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.isHidden = false
        
    }
    
    
    
    
    func configUI() {
        self.view.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 15
        self.titleLabel.text = tittleString
        self.titleLabel.adjustsFontSizeToFitWidth = true
        fillDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.containerView.isHidden = false
    }
    
    func fillDetail() {
        switch tittleString {
        case "Ingredients":
            var maltInfo: String = "Malts:\n"
            if let malts = ingredientsInfo?.malt {
                for malt in malts {
                    maltInfo = maltInfo  + "\(malt.name ?? "") \(malt.amount?.value?.formatterAmount() ?? "") \(malt.amount?.unit ?? "") \n"
                }
            }
            var hopInfo: String = "\nHops:\n"
            if let hops = ingredientsInfo?.hops {
                for hop in hops {
                    hopInfo = hopInfo  + "\(hop.name ?? "") \(hop.amount?.value?.formatterAmount() ?? "") \(hop.add ?? "") \(hop.attribute ?? "") \n"
                }
            }
            var yeastInfo: String = "\nYeast:\n"
            if let yeast = ingredientsInfo?.yeast {
                yeastInfo = yeastInfo + yeast
            }
            detailLabel.text = maltInfo + hopInfo + yeastInfo
        case "Food pairing":
            var foodInfo: String = ""
            if let foods = pairingInfo {
                for food in foods {
                    foodInfo = foodInfo  + "\(food) \n"
                }
            }
            detailLabel.text = foodInfo
        case "Brewers tip":
            detailLabel.text = self.brewerTip
        default:
            detailLabel.text = ""
        }
    }
    
    // MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self.view) else { return }
        if !self.containerView.frame.contains(location) {
            self.dismissAll()
        }
    }
    
    @objc func dismissAll() {
        
        self.view.backgroundColor = .clear
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onExit(_ sender: Any) {
        self.dismissAll()
    }
    
}
