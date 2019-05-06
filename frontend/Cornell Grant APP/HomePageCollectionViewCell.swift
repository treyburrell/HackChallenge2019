//
//  HomePageCollectionViewCell.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/22/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import UIKit

class HomePageCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var name: UILabel!
    var org: UILabel!
    var amt: UILabel!
    var due: UILabel!
    let pad: CGFloat = 8

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "comp")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(name)
        org = UILabel()
        org.translatesAutoresizingMaskIntoConstraints = false
        org.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(org)
        amt = UILabel()
        amt.translatesAutoresizingMaskIntoConstraints = false
        amt.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(amt)
        due = UILabel()
        due.translatesAutoresizingMaskIntoConstraints = false
        due.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(due)
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            ])
        NSLayoutConstraint.activate([
            amt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            amt.topAnchor.constraint(equalTo: name.bottomAnchor),
            ])
        NSLayoutConstraint.activate([
            org.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            org.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            ])
        NSLayoutConstraint.activate([
            due.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            due.topAnchor.constraint(equalTo: org.bottomAnchor),
            ])
    }
    func configure(for homegrant: HomeGrant) {
        name.text = homegrant.Grantname
        org.text = homegrant.Grantorg
        amt.text = homegrant.Grantamt
        due.text = homegrant.Grantdue
//        imageView.image = homegrant.Grantimage
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
