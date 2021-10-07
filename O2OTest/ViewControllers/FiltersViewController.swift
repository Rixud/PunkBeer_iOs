//
//  FiltersViewController.swift
//
//  Created by Luis Guerra on 10/6/21.
//

import UIKit

class FiltersViewController: UIViewController {
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var perPage: UITextField!
    @IBOutlet weak var minIBU: UITextField!
    @IBOutlet weak var maxIBU: UITextField!
    @IBOutlet weak var minABV: UITextField!
    @IBOutlet weak var maxABV: UITextField!
    @IBOutlet weak private var ibuBox: UIView!
    @IBOutlet weak private var abvBox: UIView!
    
    var perPageOptions = ["25","30","50","80"]
    
    var lastFilter = FilterModel()

    var tittleString: String = "Filters"
    var controller : SearchTableViewController?
    
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
        
        let ibuBoxTapGesture = UITapGestureRecognizer(target: self, action: #selector(ibuBoxTap(sender:)))
        ibuBox.isUserInteractionEnabled = true
        ibuBox.addGestureRecognizer(ibuBoxTapGesture)
        
        let abvBoxTapGesture = UITapGestureRecognizer(target: self, action: #selector(abvBoxTap(sender:)))
        abvBox.isUserInteractionEnabled = true
        abvBox.addGestureRecognizer(abvBoxTapGesture)
        
        let pickerPerPage = UIPickerView()
        pickerPerPage.delegate = self
        perPage.inputView = pickerPerPage
        
        perPage.text = lastFilter.perPage
        minIBU.text = lastFilter.minIBU
        maxIBU.text = lastFilter.maxIBU
        minABV.text = lastFilter.minABV
        maxABV.text = lastFilter.maxABV
        ibuBox.backgroundColor = lastFilter.filterIBU ? UIColor(named: "detailColor") : UIColor(named: "labelColor")
        abvBox.backgroundColor = lastFilter.filterABV ? UIColor(named: "detailColor") : UIColor(named: "labelColor")
        
    }
    
    func updateLastFilter() {
        lastFilter.perPage = perPage.text ?? K.perPage
        lastFilter.minIBU = minIBU.text ?? K.minIBU
        lastFilter.maxIBU = maxIBU.text ?? K.maxIBU
        lastFilter.minABV = minABV.text ?? K.minABV
        lastFilter.maxABV = maxABV.text ?? K.maxABV
        lastFilter.updateFilterString()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.containerView.isHidden = false
    }
    
    @objc func ibuBoxTap(sender: UITapGestureRecognizer) {
        lastFilter.filterIBU = !lastFilter.filterIBU
        ibuBox.backgroundColor = lastFilter.filterIBU ? UIColor(named: "detailColor") : UIColor(named: "labelColor")
        lastFilter.updateFilterString()
    }
    
    @objc func abvBoxTap(sender: UITapGestureRecognizer) {
        lastFilter.filterABV = !lastFilter.filterABV
        abvBox.backgroundColor = lastFilter.filterABV ? UIColor(named: "detailColor") : UIColor(named: "labelColor")
        lastFilter.updateFilterString()
    }
    
    
    // MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self.view) else { return }
        if !self.containerView.frame.contains(location) {
            updateLastFilter()
            self.controller?.callAPI(scroll: false)
            self.dismissAll()
        } else {
            view.endEditing(true)
            updateLastFilter()
            self.controller?.callAPI(scroll: false)
        }
    }
    
    @objc func dismissAll() {
        controller?.lastFilter = self.lastFilter
        self.view.backgroundColor = .clear
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func onExit(_ sender: Any) {
        self.dismissAll()
    }
    
}

extension FiltersViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return perPageOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return perPageOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        controller?.perPage = Int(perPageOptions[row]) ?? 25
        lastFilter.perPage = perPageOptions[row]
        perPage.text = lastFilter.perPage
        controller?.lastFilter = self.lastFilter
        view.endEditing(true)
        Api.updateURLWithPage(page: String(1), lastSearch: "", perPage: perPageOptions[row])
    }
}
