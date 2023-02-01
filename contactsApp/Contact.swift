//
//  Contact.swift
//  contactsApp
//
//  Created by Bekmuldin Edilbek Ersinbekovich on 26.01.2023.
//

import UIKit

enum Gender {
    case male
    case female
}

struct Contact {
    let fullName: String?
    let phoneNumber: String?
    let avaImage: UIImage?
    let gender: Gender
}

