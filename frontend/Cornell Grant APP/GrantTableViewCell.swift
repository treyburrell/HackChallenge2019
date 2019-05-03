//
//  GrantTableViewCell.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/21/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import UIKit
import SnapKit


class GrantTableViewCell: UITableViewCell {
    var name : UILabel!
    var org: UILabel!
    var amt: UILabel!
    var due: UILabel!
//    var dcrp: UILabel!
    let pad: CGFloat = 8
    let nameHeight: CGFloat = 20
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        name = UILabel()
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(name)
        org = UILabel()
        org.textColor = .black
        org.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(org)
        amt = UILabel()
        amt.textColor = .black
        amt.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(amt)
        due = UILabel()
        due.textColor = .black
        due.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(due)
//        dcrp = UILabel()
//        dcrp.font = UIFont.systemFont(ofSize: 10)
//        contentView.addSubview(dcrp)
    
        setupConstraints()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for grant: HomeGrant){
        name.text = grant.Grantname
        org.text = grant.Grantorg
        amt.text = grant.Grantamt
        due.text = grant.Grantdue
//        dcrp.text = grant.Grantdescription
        
    }
    func setupConstraints() {
        name.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(pad)
            make.height.equalTo(nameHeight)
        }
        amt.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.trailing).offset(pad)
            make.trailing.equalToSuperview().offset(-pad)
            make.height.equalTo(nameHeight)
            make.top.equalTo(name.snp.top)
        }
        org.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.leading)
            make.top.equalTo(name.snp.bottom)
            make.height.equalTo(nameHeight)
        }
        due.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.trailing).offset(pad)
            make.top.equalTo(amt.snp.bottom)
            make.trailing.equalToSuperview().offset(-pad)
            make.height.equalTo(nameHeight)
        }
    }
}




















