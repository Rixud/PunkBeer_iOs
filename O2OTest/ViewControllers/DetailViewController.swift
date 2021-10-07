//
//  DetailViewController.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/7/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var ibuLabel: UILabel!
    @IBOutlet weak var ebcLabel: UILabel!
    @IBOutlet weak var srmLabel: UILabel!
    @IBOutlet weak var phLabel: UILabel!
    @IBOutlet weak var volLabel: UILabel!
    @IBOutlet weak var favImage: UIImageView!


    
    var beerData:BeerModel?
    var isFav: Bool = false
    var favList: [Int] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        favList = UserDefaults.standard.object(forKey: "myFavs") as? [Int] ?? []
        let favTapGesture = UITapGestureRecognizer(target: self, action: #selector(favTap(sender:)))
        favImage.isUserInteractionEnabled = true
        favImage.addGestureRecognizer(favTapGesture)
        updateUI()
        // Do any additional setup after loading the view.
        
    }
    
    func updateUI() {
        if let data = beerData {
            if let URL = URL(string: data.image_url ?? "") {
                self.beerImage.kf.setImageWithRetry(with: URL)
            }
            nameLabel.text = data.name
            tagLabel.text = data.tagLine
            descriptionLabel.text = data.description
            abvLabel.text = "\(data.abv?.formatterAmount() ?? "0.0")  ABV"
            ibuLabel.text = "\(data.ibu?.formatterAmount() ?? "0.0")  IBU"
            ebcLabel.text = "\(data.ebc?.formatterAmount() ?? "0.0")  EBC"
            srmLabel.text = "\(data.srm?.formatterAmount() ?? "0.0")  SRM"
            phLabel.text = "ph \(data.ph?.formatterAmount() ?? "0.0")"
            volLabel.text = "\(data.volume?.value?.formatterAmount() ?? "0.0") \(data.volume?.unit ?? "")"
            isFav = searchOnFavs()
            favImage.image = isFav ? UIImage(named:"removeFav") : UIImage(named:"addFav")
        }
    }
    
    @objc func favTap(sender: UITapGestureRecognizer) {
        isFav = !isFav
        favImage.image = isFav ? UIImage(named:"removeFav") : UIImage(named:"addFav")
        if isFav {
            favList.append(beerData?.id ?? 1)
            UserDefaults.standard.set(favList, forKey: "myFavs")
        } else {
            favList = favList.filter { $0 != beerData?.id }
            UserDefaults.standard.set(favList, forKey: "myFavs")
        }
        
    }
    
    func searchOnFavs() -> Bool {
        for fav in favList {
            if beerData?.id == fav {
                return true
            }
        }
        return false

    }
    
    @IBAction func openDetail(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoDetailViewController") as? InfoDetailViewController {
            vc.modalPresentationStyle = .overCurrentContext
            vc.tittleString = sender.titleLabel?.text
            if let data = beerData {
                vc.brewerTip = data.brewers_tips
                vc.ingredientsInfo = data.ingredients
                vc.pairingInfo = data.food_pairing
            }
            self.present(vc, animated: false, completion: nil)
        }
    }
}
