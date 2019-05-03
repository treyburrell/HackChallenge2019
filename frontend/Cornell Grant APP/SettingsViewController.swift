//
//  SettingsViewController.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/22/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var name: UITextField!
    var year: UITextField!
    var gender: UITextField!
    var ethnicity: UITextField!
    var address: UITextField!

    var labelA: UILabel!
    var labelB: UILabel!
    var labelC: UILabel!
    var labelD: UILabel!
    var labelE: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        
        
        name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textAlignment = .left
        name.textColor = .black
        name.backgroundColor = .white
        name.font = UIFont.systemFont(ofSize: 20)
        name.layer.borderWidth = 0.9
        name.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(name)
        
        year = UITextField()
        year.translatesAutoresizingMaskIntoConstraints = false
        year.textAlignment = .left
        year.textColor = .black
        year.backgroundColor = .white
        year.font = UIFont.systemFont(ofSize: 20)
        year.layer.borderWidth = 0.9
        year.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(year)
        
        gender = UITextField()
        gender.translatesAutoresizingMaskIntoConstraints = false
        gender.textAlignment = .left
        gender.textColor = .black
        gender.backgroundColor = .white
        gender.font = UIFont.systemFont(ofSize: 20)
        gender.layer.borderWidth = 0.9
        gender.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(gender)
        
        ethnicity = UITextField()
        ethnicity.translatesAutoresizingMaskIntoConstraints = false
        ethnicity.textAlignment = .left
        ethnicity.textColor = .black
        ethnicity.backgroundColor = .white
        ethnicity.font = UIFont.systemFont(ofSize: 20)
        ethnicity.layer.borderWidth = 0.9
        ethnicity.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(ethnicity)
        
        address = UITextField()
        address.translatesAutoresizingMaskIntoConstraints = false
        address.textAlignment = .left
        address.textColor = .black
        address.backgroundColor = .white
        address.font = UIFont.systemFont(ofSize: 20)
        address.layer.borderWidth = 0.9
        address.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(address)
        
        labelA = UILabel()
        labelA.translatesAutoresizingMaskIntoConstraints = false
        labelA.text = "name"
        labelA.textColor = .black
        labelA.textAlignment = .right
        labelA.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(labelA)
        
        labelB = UILabel()
        labelB.translatesAutoresizingMaskIntoConstraints = false
        labelB.text = "year"
        labelB.textColor = .black
        labelB.textAlignment = .right
        labelB.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(labelB)
        
        labelC = UILabel()
        labelC.translatesAutoresizingMaskIntoConstraints = false
        labelC.text = "gender"
        labelC.textColor = .black
        labelC.textAlignment = .right
        labelC.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(labelC)
        
        labelD = UILabel()
        labelD.translatesAutoresizingMaskIntoConstraints = false
        labelD.text = "ethnicity"
        labelD.textColor = .black
        labelD.textAlignment = .right
        labelD.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(labelD)
        
        labelE = UILabel()
        labelE.translatesAutoresizingMaskIntoConstraints = false
        labelE.text = "address"
        labelE.textColor = .black
        labelE.textAlignment = .right
        labelE.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(labelE)

        setupConstraints()
    }
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            name.leadingAnchor.constraint(equalTo: labelA.trailingAnchor, constant: 30),
            name.heightAnchor.constraint(equalToConstant: 25),
            name.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            year.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            year.leadingAnchor.constraint(equalTo: labelB.trailingAnchor, constant: 30),
            year.heightAnchor.constraint(equalToConstant: 25),
            year.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            gender.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 10),
            gender.leadingAnchor.constraint(equalTo: labelC.trailingAnchor, constant: 30),
            gender.heightAnchor.constraint(equalToConstant: 25),
            gender.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            ethnicity.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 10),
            ethnicity.leadingAnchor.constraint(equalTo: labelD.trailingAnchor, constant: 30),
            ethnicity.heightAnchor.constraint(equalToConstant: 25),
            ethnicity.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            address.topAnchor.constraint(equalTo: ethnicity.bottomAnchor, constant: 10),
            address.leadingAnchor.constraint(equalTo: labelE.trailingAnchor, constant: 30),
            address.heightAnchor.constraint(equalToConstant: 25),
            address.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            labelA.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            labelA.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelA.heightAnchor.constraint(equalToConstant: 25),
            labelA.widthAnchor.constraint(equalToConstant: 100)
            ])
        NSLayoutConstraint.activate([
            labelB.topAnchor.constraint(equalTo: labelA.bottomAnchor, constant: 10),
            labelB.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelB.heightAnchor.constraint(equalToConstant: 25),
            labelB.widthAnchor.constraint(equalToConstant: 100)
            ])
        NSLayoutConstraint.activate([
            labelC.topAnchor.constraint(equalTo: labelB.bottomAnchor, constant: 10),
            labelC.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelC.heightAnchor.constraint(equalToConstant: 25),
            labelC.widthAnchor.constraint(equalToConstant: 100)
            ])
        NSLayoutConstraint.activate([
            labelD.topAnchor.constraint(equalTo: labelC.bottomAnchor, constant: 10),
            labelD.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelD.heightAnchor.constraint(equalToConstant: 25),
            labelD.widthAnchor.constraint(equalToConstant: 100)
            ])
        NSLayoutConstraint.activate([
            labelE.topAnchor.constraint(equalTo: labelD.bottomAnchor, constant: 10),
            labelE.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelE.heightAnchor.constraint(equalToConstant: 25),
            labelE.widthAnchor.constraint(equalToConstant: 100)
            ])
    }
    let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
}
