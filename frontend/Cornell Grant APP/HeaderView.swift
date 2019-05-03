//
//  HeaderView.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/26/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    var label1: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label1 = UILabel(frame: .zero)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.text = "Welcome to the Grant App"
        label1.font = UIFont.systemFont(ofSize: 30)
        addSubview(label1)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label1.centerYAnchor.constraint(equalTo: centerYAnchor),
            label1.leadingAnchor.constraint(equalTo: leadingAnchor)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
