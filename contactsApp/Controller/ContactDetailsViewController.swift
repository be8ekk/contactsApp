//
//  ContactDetailsViewController.swift
//  contactsApp
//
//  Created by Bekmuldin Edilbek Ersinbekovich on 01.02.2023.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    public var contact: Contact?
    
    public var didDeleteContact: ((Contact) -> Void)?
    
    private let avaImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fullName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 16, weight: .bold)
        name.textAlignment = .left
        return name
    }()
    
    private let phoneNumber: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let callButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Call", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func deleteButtonTapped() {
        guard let contact = contact else { return }
        didDeleteContact?(contact)
        navigationController?.popViewController(animated: true)
    }
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact Details"
        addSubViews()
        
        guard let contact = contact else { return }
        
        avaImage.image = contact.avaImage
        fullName.text = contact.fullName
        phoneNumber.text = contact.phoneNumber
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self, action: #selector(editTapped)
        )
    }
    
    @objc func editTapped() {
        let pushedViewController = UIViewController()
        view.backgroundColor = .systemTeal
        navigationController?.pushViewController(pushedViewController, animated: true)
    }
    
    private func addSubViews(){
        stackView.addArrangedSubview(fullName)
        stackView.addArrangedSubview(phoneNumber)
        buttonStackView.addArrangedSubview(callButton)
        buttonStackView.addArrangedSubview(deleteButton)
        view.addSubview(avaImage)
        view.addSubview(stackView)
        view.addSubview(buttonStackView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 116),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            avaImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 116),
            avaImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            avaImage.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -20),
            avaImage.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
}
