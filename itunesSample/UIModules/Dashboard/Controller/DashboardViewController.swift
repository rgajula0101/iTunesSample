//
//  ViewController.swift
//  itunesSample
//
//  Created by Rakesh Kumar on 04/16/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var itunesTableView: UITableView!
    
    let cellId = "ITunesSearchResultCell"
    var dashBoardViewModel = DashboardViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var itunesDict = Dictionary<Kind,[ItunesAPIResult]>()
    var allkeysArray = [Kind]()
    var favItemArray = [ItunesAPIResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "itunes Search"
        setupSearchBar()
        fetchItunes(searchTerms: "Micheal%20Jackson")
        // Do any additional setup after loading the view.
    }
    
    private func setupSearchBar(){
        searchController.searchResultsUpdater = self
        itunesTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.barTintColor = UIColor.white
    }
    
    private func fetchItunes(searchTerms: String){
        dashBoardViewModel.getItunesWithSearchTerm(searchTerms , parentViewController: self) { [weak self] (success, message) in
            DispatchQueue.main.async {
                self?.handleResponse(success: success, message: message)
            }
        }
    }
    
    private func handleResponse(success:Bool?,message:String?){
        guard let success = success else {
            fatalError()
        }
        allkeysArray.removeAll()
        if success {
            
            if let results = dashBoardViewModel.searchResult?.results {
                itunesDict = Dictionary(grouping: results,
                                        by: { item in item.kind })
                
                for item in itunesDict {
                    let key = item.key
                    allkeysArray.append(key)
                }
                
            }
            
            
            
            itunesTableView.dataSource = self
            itunesTableView.reloadData()
        } else {
            handleErrorMessage(message: message)
        }
        
        
    }
    
    
    
    private func handleErrorMessage(message : String?){
        guard let message = message  else {
            return
        }
        showAlert(title: "Alert", message: message)
    }
    
    @objc
    func favButtonClick(sender: CustomButton) {
        if sender.section == 0 {
            return
        }
        guard let obj = itunesDict[allkeysArray[sender.section - 1]]?[sender.row] else {
            return
        }
        favItemArray.append(obj)
        itunesTableView.reloadData()
    }
    
    
}

extension  DashboardViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return allkeysArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favItemArray.count
        } else {
            return itunesDict[allkeysArray[section - 1]]?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Favourite"
        } else {
            return allkeysArray[section - 1].rawValue
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ITunesSearchResultCell
        if indexPath.section == 0 {
            cell.iTunesResult = favItemArray[indexPath.row]
            
        } else {
            if let item = itunesDict[allkeysArray[indexPath.section - 1]]?[indexPath.row] {
                cell.iTunesResult = item
            }
        }
        
        
        cell.favButton.addTarget(self, action: #selector(favButtonClick), for: .touchUpInside)
        cell.favButton.row = indexPath.row
        cell.favButton.section = indexPath.section
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
}

extension DashboardViewController: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        guard let queryString = searchController.searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        if !queryString.isEmpty {
            fetchItunes(searchTerms: queryString)
        }
        
        
    }
}
extension DashboardViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        if itunesDict.count == 0 {
            fetchItunes(searchTerms: "Micheal%20Jackson")
        }
        
    }
}
