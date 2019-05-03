//
//  ViewController.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/21/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import UIKit
import SnapKit
import Hero

class ViewController: UIViewController {

    
    var tableView: UITableView!
    let reuseIdentifier = "IntroTable"
    var grants = [HomeGrant]()
    var filteredGrants = [HomeGrant]()
    let cellHeight: CGFloat = 50
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView = UITableView()
        let g1 = HomeGrant(Grantname: "steiner", Grantorg: "cornell", Grantamt: "1998", Grantdue: "may 2020")
        let g2 = HomeGrant(Grantname: "selwyn", Grantorg: "North", Grantamt: "2002", Grantdue: "may 2020")
        let g3 = HomeGrant(Grantname: "shelby", Grantorg: "North", Grantamt: "2002", Grantdue: "may 2020")

//        , Grantdescription: "poor"
        

        grants = [g1,g2,g3]

        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(GrantTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Grants"
        tableView.tableHeaderView = searchController.searchBar
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        view.addSubview(tableView)
        setUpConstraints()
        getGrants()
}
    func getGrants() {
        NetworkManager.getGrants { grantsArray in
        self.grants = grantsArray
        DispatchQueue.main.async {
        self.tableView.reloadData()
        }
    }
}

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredGrants = grants.filter({( grant : HomeGrant) -> Bool in
            return grant.Grantname.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
extension ViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GrantTableViewCell
            if isFiltering() {
                let money = filteredGrants[indexPath.row]
                cell.configure(for: money)
            } else {
                let money = grants[indexPath.row]
                cell.configure(for: money)
            }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredGrants.count
        }
            return grants.count
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
