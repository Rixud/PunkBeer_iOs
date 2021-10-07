//
//  ProfileViewController.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var logoGif: GifImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.logoGif.animate(withGIFNamed: "logo")

        logoGif.startAnimating()

    }
    



}

