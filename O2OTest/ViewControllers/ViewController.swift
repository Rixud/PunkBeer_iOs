//
//  ViewController.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var logoGif: GifImageView!
    var beerList:[BeerModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        logoGif.prepareForAnimation(withGIFNamed: "zelle_tutorial")
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.logoGif.animate(withGIFNamed: "logo")

        logoGif.startAnimating()
        Api.callApi(filterString: "", completionHandler:{ beerList, error in
            
            if let beerList = beerList {
                self.beerList = beerList
            }
          })

    }
    
    @IBAction func openCatalogue(_ sender: Any) {
        performSegue(withIdentifier: "toCatalogue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toCatalogue" {
               if let vc = segue.destination as? SearchTableViewController{
                vc.beerList = self.beerList
               }
           }
       }


}

