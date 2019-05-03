//
//  HomeViewController.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/22/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import UIKit
import Hero

class HomeViewController: UIViewController {
    
    var collectionView: UICollectionView!
    let collectionreuseIdentifier = "HomeTable"
    let headerid = "head"

    var homecell = [HomeGrant]()
    let padding : CGFloat = 8
    let cellpad: CGFloat = 40
    let cellpad2: CGFloat = 10
    override func viewDidLoad() {
        super.viewDidLoad()
            title = "Giving Tree"
            view.backgroundColor = .white
        
        let g1 = HomeGrant( Grantname: "STEINER", Grantorg: "CORNELL", Grantamt: "$2", Grantdue: "may 2020")
        let g2 = HomeGrant( Grantname: "selwyn", Grantorg: "North", Grantamt: "2002", Grantdue: "may 2020")
        let g3 = HomeGrant( Grantname: "shelby", Grantorg: "North", Grantamt: "2002", Grantdue: "may 2020")
        
            //, Grantdescription: "poor"

            homecell = [g1,g2,g3,g2,g3,g2,g3,g2,g3,g2,g3,g2,g3,g2,g3]
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = cellpad2
            layout.minimumLineSpacing = cellpad
            collectionView = UICollectionView(frame: .zero, collectionViewLayout:
                layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .white
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: collectionreuseIdentifier)
            collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerid)
            view.addSubview(collectionView)
            setUpConstraints()
            getGrants()
        }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    func getGrants() {
        NetworkManager.getGrants { homecell in
            self.homecell = homecell
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionreuseIdentifier, for: indexPath) as! HomePageCollectionViewCell
        let thing = homecell[indexPath.item]
        cell.configure(for: thing)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homecell.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerid, for: indexPath)
        return headerView
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width - padding * 3) / 2.0
        return CGSize(width: length, height: length)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 33)
    }
}



