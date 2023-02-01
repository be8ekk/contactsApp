//
//  ContactTableViewCell.swift
//  contactsApp
//
//  Created by Bekmuldin Edilbek Ersinbekovich on 01.02.2023.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    static let identifier = "ContactTableViewCell"
    
    private let avaImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    private let fullName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 16, weight: .semibold)
        name.textAlignment = .natural
        name.text = "full name"
        return name
    }()
    
    private let phoneNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .natural
        label.text = "87005385838"
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
    
    private func addSubviewToStackView() {
        stackView.addSubview(fullName)
        stackView.addSubview(phoneNumber)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        contentView.addSubview(avaImage)
        
        addSubviewToStackView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            avaImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avaImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            avaImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avaImage.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -8),
            
            fullName.heightAnchor.constraint(equalToConstant: 24),
            fullName.topAnchor.constraint(equalTo: stackView.topAnchor),
            
            phoneNumber.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 8),
            phoneNumber.heightAnchor.constraint(equalToConstant: 24)
            
            
        ])
    }
    
    
    func config(info: Contact) {
        fullName.text = info.fullName
        phoneNumber.text = info.phoneNumber
        if info.gender == .female {
            avaImage.image = UIImage(named: "woman")
        } else {
            avaImage.image = UIImage(named: "man")
        }
    }
    
}
