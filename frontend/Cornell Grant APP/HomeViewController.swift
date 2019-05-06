//
//  HomeViewController.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/22/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    var collectionView: UICollectionView!
    let collectionreuseIdentifier = "HomeTable"
    let headerid = "head"
    var homeLabel: UILabel!
    var titleLabel: UILabel!

    var homecell = [HomeGrant]()
    let padding : CGFloat = 8
    let cellpad: CGFloat = 40
    let cellpad2: CGFloat = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            title = "Home"
            view.backgroundColor = .white
        
        
        let g1 = HomeGrant( Grantname: "STEINER", Grantorg: "CORNELL", Grantamt: "$2", Grantdue: "may 2020")
        let g2 = HomeGrant( Grantname: "selwyn", Grantorg: "North", Grantamt: "2002", Grantdue: "may 2020")
        let g3 = HomeGrant( Grantname: "shelby", Grantorg: "North", Grantamt: "2002", Grantdue: "may 2020")
        
            homeLabel = UILabel()
            homeLabel.text = "Below you can find the grants that we've recommended for you. If you want to search through our entire list, use the search tab"
            homeLabel.translatesAutoresizingMaskIntoConstraints = false
//            homeLabel.lineBreakMode = .byCharWrapping
            homeLabel.numberOfLines = 4
            homeLabel.textColor = .black
            homeLabel.textAlignment = .center
            homeLabel.font = UIFont.systemFont(ofSize: 16)
            homeLabel.allowsDefaultTighteningForTruncation = true
            self.view.addSubview(homeLabel)
        
            titleLabel = UILabel()
            titleLabel.text = "Welcome to the Grant App!"
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.textColor = .black
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 23)
            self.view.addSubview(titleLabel)
        
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
   
            view.addSubview(collectionView)
            setUpConstraints()
            getGrants()
        }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.widthAnchor.constraint(equalToConstant: 370)
            ])
        NSLayoutConstraint.activate([
            homeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            homeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeLabel.widthAnchor.constraint(equalToConstant: 370)
            ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: homeLabel.bottomAnchor),
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

}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width - padding * 3)/2
        return CGSize(width: length, height: length)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 33)
    }
}



