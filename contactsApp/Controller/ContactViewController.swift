//
//  ViewController.swift
//  contactsApp
//
//  Created by Bekmuldin Edilbek Ersinbekovich on 24.01.2023.
//

import UIKit

class ContactViewController: UIViewController, NewContactViewControllerDelegate {
    
    public var contacts: [Contact] = [
        Contact(fullName: "Edilbek", phoneNumber: "87085442864", avaImage: UIImage(systemName: "man"), gender: Gender.male),
        Contact(fullName: "Sanzhar", phoneNumber: "87074536323", avaImage: UIImage(named: "man"), gender: Gender.male),
        Contact(fullName: "Arnur", phoneNumber: "87781324233", avaImage: UIImage(named: "man"), gender: Gender.male),
    ]
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        table.backgroundColor = .systemBackground
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        title = "Contacts"
        
        tableView.delegate = self
        tableView.dataSource = self
 
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        let pushedViewController = NewContactViewController()
        pushedViewController.delegate = self
        navigationController?.pushViewController(pushedViewController, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func didAddContact(contact: Contact) {
        contacts.append(contact)
        tableView.reloadData()
    }
    
}

extension ContactViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        let contact = contacts[indexPath.row]
        cell.config(info: contact) 
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushedViewController = ContactDetailsViewController()
        pushedViewController.contact = contacts[indexPath.row]
        pushedViewController.didDeleteContact = { [weak self] contact in
            self?.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(pushedViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
