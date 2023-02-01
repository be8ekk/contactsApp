//
//  NewContactViewController.swift
//  contactsApp
//
//  Created by Bekmuldin Edilbek Ersinbekovich on 01.02.2023.
//

import UIKit

protocol NewContactViewControllerDelegate: AnyObject {
    func didAddContact(contact: Contact)
        
}

class NewContactViewController: UIViewController {
    
    weak var delegate: NewContactViewControllerDelegate?
    
    private let fullNameTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .white
        text.leftViewMode = .always
        text.attributedPlaceholder = NSAttributedString (
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]
        )
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: text.frame.height))
        text.keyboardType = .emailAddress
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        text.layer.cornerRadius = 8
        text.autocapitalizationType = .none
        text.returnKeyType = .done
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray.cgColor
        text.autocorrectionType = .no
        return text
    }()
    
    private let phoneNumberTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .white
        text.leftViewMode = .always
        text.attributedPlaceholder = NSAttributedString (
            string: "Phone number",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]
        )
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: text.frame.height))
        text.keyboardType = .numberPad
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        text.layer.cornerRadius = 8
        text.autocapitalizationType = .none
        text.returnKeyType = .done
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray.cgColor
        return text
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let gender = ["male", "female"]
    private var selectedValue = ""
    
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(saveButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func saveButtonTapped(sender: UIButton){
        guard
            let fullName = fullNameTextField.text,
            let phoneNumber = phoneNumberTextField.text
        else { return }
        
        var newContact: Contact
        if selectedValue == "male" {
            newContact = Contact(
                fullName: fullName, phoneNumber: phoneNumber, avaImage: UIImage(systemName: "man"), gender: Gender.male
            )
        } else {
            newContact = Contact(
                fullName: fullName, phoneNumber: phoneNumber, avaImage: UIImage(systemName: "woman"), gender: Gender.female
            )
        }
        delegate?.didAddContact(contact: newContact)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Contact"
        view.backgroundColor = .systemBackground
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.center = self.view.center
        addSubViews()
        
    }
    
    private func addSubViews(){
        stackView.addArrangedSubview(fullNameTextField)
        stackView.addArrangedSubview(phoneNumberTextField)
        view.addSubview(stackView)
        view.addSubview(pickerView)
        view.addSubview(saveButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: pickerView.topAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 140),
            
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

extension NewContactViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = gender[row]
        selectedValue = row
        return row
    }
    
}
