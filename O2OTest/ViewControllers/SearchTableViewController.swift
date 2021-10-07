//
//  SearchTableViewController.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import Foundation
import UIKit

class SearchTableViewController: UIViewController {
    
    //MARK: Variables
    private let cellIdenetifier = "beerCell"
    private let cellIdenetifierPag = "pagCell"
    @IBOutlet weak var beerTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterImage: UIImageView!
    var currentPage: Int = 1
    var lastSearch: String = ""
    var lastFilter = FilterModel()
    var perPage: Int = 25
    var beerList:[BeerModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerTable.delegate = self
        beerTable.dataSource = self
        searchBar.delegate = self
        
        let filtersTapGesture = UITapGestureRecognizer(target: self, action: #selector(filtersTap(sender:)))
        filterImage.isUserInteractionEnabled = true
        filterImage.addGestureRecognizer(filtersTapGesture)
        
        beerTable.backgroundColor = UIColor(named: "backgroundColor")
        self.registerTableViewCell()
        if beerList == nil {
            callAPI(scroll: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    
    @objc func filtersTap(sender: UITapGestureRecognizer) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FiltersViewController") as? FiltersViewController {
            vc.modalPresentationStyle = .overCurrentContext
            vc.controller = self
            vc.lastFilter = self.lastFilter
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func callAPI(scroll:Bool) {
        Api.callApi(filterString: lastFilter.filterString, completionHandler:{ beerList, error in
            
            if let beerList = beerList {
                self.beerList = beerList
                DispatchQueue.main.async {
                    if scroll {
                        self.beerTable.scroll(to: .top, animated: true)
                    }
                    self.beerTable.reloadData()
                }
            }
          })
    }
    
    func nextPage() {
        currentPage = currentPage + 1
        Api.updateURLWithPage(page: String(currentPage), lastSearch: lastSearch, perPage: String(perPage))
        callAPI(scroll: true)
        
    }
    
    func previousPage() {
        currentPage = currentPage - 1
        Api.updateURLWithPage(page: String(currentPage), lastSearch: lastSearch, perPage: String(perPage))
        callAPI(scroll: true)
    }
    
    
    func registerTableViewCell(){
        let cell = UINib(nibName: "BeerTableViewCell", bundle: nil)
        self.beerTable.register(cell, forCellReuseIdentifier: cellIdenetifier)
        let cellPag = UINib(nibName: "PagTableViewCell", bundle: nil)
        self.beerTable.register(cellPag, forCellReuseIdentifier: cellIdenetifierPag)
    }
    


}

//MARK: - UITableViewDataSource
extension SearchTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = beerList?.count ?? 0
        return count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item < beerList?.count ?? 0 {
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdenetifierPag, for: indexPath) as! PagTableViewCell
            cell.cellWidth.constant = tableView.frame.width
            if beerList?.count ?? 0 > 0 {
                let pageData = PagesModel(currentPage: String(currentPage), perPage: perPage, currentCount: beerList?.count ?? 0)
                cell.controller = self
                cell.data = pageData
            } else {
                cell.data = nil
            }
            cell.selectedBackgroundView = .none
            cell.selectionStyle = .none
            return cell
        }
        
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
extension SearchTableViewController: UITableViewDelegate {
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

extension SearchTableViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_: UISearchBar, textDidChange: String) {
        lastSearch = textDidChange
        Api.updateURLWithSearchBar(searchStr: textDidChange, perPage: String(perPage))
        currentPage = 1
        callAPI(scroll: false)
        
    }
}

