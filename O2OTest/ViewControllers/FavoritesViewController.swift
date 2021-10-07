//
//  FavoritesViewController.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/7/21.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {
    private let cellIdenetifier = "beerCell"
    @IBOutlet weak var beerTable: UITableView!
    
    var beerList:[BeerModel]? = []
    var favList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerTable.delegate = self
        beerTable.dataSource = self
        favList = UserDefaults.standard.object(forKey: "myFavs") as? [Int] ?? []
        for fav in favList {
            callAPI(id: String(fav))
        }
        
        beerTable.backgroundColor = UIColor(named: "backgroundColor")
        self.registerTableViewCell()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favList = UserDefaults.standard.object(forKey: "myFavs") as? [Int] ?? []
        if favList.count != beerList?.count {
            updateBeerList()
        }
        
    }
    
    func updateBeerList() {
        beerList = []
        self.beerTable.reloadData()
        for fav in favList {
            callAPI(id: String(fav))
        }
 
    }
    
    func registerTableViewCell(){
        let cell = UINib(nibName: "BeerTableViewCell", bundle: nil)
        self.beerTable.register(cell, forCellReuseIdentifier: cellIdenetifier)
    }
    
    func callAPI(id:String) {
        Api.resetURL()
        Api.updateURLWithId(id: id)
        Api.callApi(filterString: "", completionHandler:{ beerList, error in
            
            if let beerList = beerList {
                if beerList.count > 0 {
                    self.beerList?.append(beerList[0])
                    DispatchQueue.main.async {
                        self.beerTable.reloadData()
                    }
                }
            }
          })
    }
}




//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = beerList?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdenetifier, for: indexPath) as! BeerTableViewCell
        cell.cellWidth.constant = tableView.frame.width
        if beerList?.count ?? 0 > 0 {
            if let beer = beerList?[indexPath.item] {
                cell.data = beer
            }
        }
        cell.selectedBackgroundView = .none
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Re-labelize all scrolling labels on tableview scroll
        for cell in beerTable.visibleCells {
            if let cellCast = cell as? BeerTableViewCell {
                cellCast.nameLabel.labelize = false
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? BeerTableViewCell {
            cell.nameLabel.labelize = false
            let viewDetail = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            viewDetail.beerData = beerList?[indexPath.item]
            self.navigationController?.pushViewController(viewDetail, animated: true)
        }

    }
}
//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? BeerTableViewCell {
            cell.nameLabel.labelize = false
            cell.nameLabel.restartLabel()
        }

        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
