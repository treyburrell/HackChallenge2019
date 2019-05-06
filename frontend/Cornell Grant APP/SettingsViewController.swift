//
//  SettingsViewController.swift
//  Cornell Grant APP
//
//  Created by Library User on 4/22/19.
//  Copyright © 2019 Steiner Abayie. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var nameTextField: UITextField!
    var yearTextField: UITextField!
    var genderTextField: UITextField!
    var ethnicityTextField: UITextField!
    var netIDTextField: UITextField!

    var name: UILabel!
    var year: UILabel!
    var gender: UILabel!
    var ethnicity: UILabel!
    var NetID: UILabel!
    
    var save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        
        
        nameTextField = UITextField()
        nameTextField.text = "Name...."
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.textAlignment = .left
        nameTextField.textColor = .black
        nameTextField.backgroundColor = .white
        nameTextField.font = UIFont.systemFont(ofSize: 20)
        nameTextField.layer.borderWidth = 0.9
        nameTextField.layer.cornerRadius = 5
        nameTextField.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(nameTextField)
        
        yearTextField = UITextField()
        yearTextField.text = "Year...."
        yearTextField.translatesAutoresizingMaskIntoConstraints = false
        yearTextField.textAlignment = .left
        yearTextField.textColor = .black
        yearTextField.backgroundColor = .white
        yearTextField.font = UIFont.systemFont(ofSize: 20)
        yearTextField.layer.borderWidth = 0.9
        yearTextField.layer.cornerRadius = 5
        yearTextField.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(yearTextField)
        
        genderTextField = UITextField()
        genderTextField.text = "Gender (Optional)..."
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        genderTextField.textAlignment = .left
        genderTextField.textColor = .black
        genderTextField.backgroundColor = .white
        genderTextField.font = UIFont.systemFont(ofSize: 20)
        genderTextField.layer.borderWidth = 0.9
        genderTextField.layer.cornerRadius = 5
        genderTextField.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(genderTextField)
        
        ethnicityTextField = UITextField()
        ethnicityTextField.text = "Ethnicity (Optional)"
        ethnicityTextField.translatesAutoresizingMaskIntoConstraints = false
        ethnicityTextField.textAlignment = .left
        ethnicityTextField.textColor = .black
        ethnicityTextField.backgroundColor = .white
        ethnicityTextField.font = UIFont.systemFont(ofSize: 20)
        ethnicityTextField.layer.borderWidth = 0.9
        ethnicityTextField.layer.cornerRadius = 5
        ethnicityTextField.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(ethnicityTextField)
        
        netIDTextField = UITextField()
        netIDTextField.text = "NetID..."
        netIDTextField.translatesAutoresizingMaskIntoConstraints = false
        netIDTextField.textAlignment = .left
        netIDTextField.textColor = .black
        netIDTextField.backgroundColor = .white
        netIDTextField.font = UIFont.systemFont(ofSize: 20)
        netIDTextField.layer.borderWidth = 0.9
        netIDTextField.layer.cornerRadius = 5
        netIDTextField.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(netIDTextField)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "name"
        name.textColor = .black
        name.textAlignment = .left
        name.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(name)
        
        year = UILabel()
        year.translatesAutoresizingMaskIntoConstraints = false
        year.text = "year"
        year.textColor = .black
        year.textAlignment = .left
        year.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(year)
        
        gender = UILabel()
        gender.translatesAutoresizingMaskIntoConstraints = false
        gender.text = "gender"
        gender.textColor = .black
        gender.textAlignment = .left
        gender.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(gender)
        
        ethnicity = UILabel()
        ethnicity.translatesAutoresizingMaskIntoConstraints = false
        ethnicity.text = "ethnicity"
        ethnicity.textColor = .black
        ethnicity.textAlignment = .left
        ethnicity.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(ethnicity)
        
        NetID = UILabel()
        NetID.translatesAutoresizingMaskIntoConstraints = false
        NetID.text = "NetID"
        NetID.textColor = .black
        NetID.textAlignment = .left
        NetID.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(NetID)

        save = UIButton()
        save.translatesAutoresizingMaskIntoConstraints = false
        save.setTitle("Save", for: .normal)
        save.setTitleColor(.blue, for: .normal)
        save.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        save.addTarget(self, action: #selector(savePress), for: .touchUpInside)
        save.backgroundColor = .red
        save.layer.cornerRadius = 5
        save.layer.borderWidth = 1
        save.layer.borderColor = UIColor.black.cgColor
    
        self.view.addSubview(save)

        
        
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            save.topAnchor.constraint(equalTo: netIDTextField.topAnchor, constant: 100),
            save.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            save.heightAnchor.constraint(equalToConstant: 25),
            save.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 30),
            nameTextField.heightAnchor.constraint(equalToConstant: 25),
            nameTextField.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            yearTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            yearTextField.leadingAnchor.constraint(equalTo: year.trailingAnchor, constant: 30),
            yearTextField.heightAnchor.constraint(equalToConstant: 25),
            yearTextField.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            genderTextField.topAnchor.constraint(equalTo: yearTextField.bottomAnchor, constant: 10),
            genderTextField.leadingAnchor.constraint(equalTo: gender.trailingAnchor, constant: 30),
            genderTextField.heightAnchor.constraint(equalToConstant: 25),
            genderTextField.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            ethnicityTextField.topAnchor.constraint(equalTo: genderTextField.bottomAnchor, constant: 10),
            ethnicityTextField.leadingAnchor.constraint(equalTo: ethnicity.trailingAnchor, constant: 30),
            ethnicityTextField.heightAnchor.constraint(equalToConstant: 25),
            ethnicityTextField.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            netIDTextField.topAnchor.constraint(equalTo: ethnicityTextField.bottomAnchor, constant: 10),
            netIDTextField.leadingAnchor.constraint(equalTo: NetID.trailingAnchor, constant: 30),
            netIDTextField.heightAnchor.constraint(equalToConstant: 25),
            netIDTextField.widthAnchor.constraint(equalToConstant: 200)
            ])
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            name.heightAnchor.constraint(equalToConstant: 25),
            name.widthAnchor.constraint(equalToConstant: 100)
            ])
        NSLayoutConstraint.activate([
            year.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            year.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            year.heightAnchor.constraint(equalToConstant: 25),
            year.widthAnchor.constraint(equalToConstant: 100)
            ])
        NSLayoutConstraint.activate([
            gender.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 10),
            gender.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            gender.heightAnchor.constraint(equalToConstant: 25),
            gender.widthAnchor.constraint(equalToConstant: 100)
            ])
        NSLayoutConstraint.activate([
            ethnicity.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 10),
            ethnicity.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            ethnicity.heightAnchor.constraint(equalToConstant: 25),
            ethnicity.widthAnchor.constraint(equalToConstant: 100)
            ])
        NSLayoutConstraint.activate([
            NetID.topAnchor.constraint(equalTo: ethnicity.bottomAnchor, constant: 10),
            NetID.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            NetID.heightAnchor.constraint(equalToConstant: 25),
            NetID.widthAnchor.constraint(equalToConstant: 100)
            ])
    }
    let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
    @objc func savePress() {
    }
}
