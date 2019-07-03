//
//  AndroidHaterModel.swift
//  UIDelegationProject
//
//  Created by Josh Hollandsworth on 7/2/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation

protocol AndroidHatersDelegate: class {
    func onSaved(haterInfo: String)
}

struct AndroidHater {
    let name: String
    let phoneNumber: String
    let emailAddress: String
    let username: String
    let password: String
}


public class AndroidHatersModel {
    
    private weak var delegate: AndroidHatersDelegate?;
    
    init(delegate: AndroidHatersDelegate) {
       self.delegate = delegate
    }
    
    private var haters: [AndroidHater] = []
    
    func addHater(hater: AndroidHater) {
        haters.append(hater)
    }

    func isValidName(text: String?) -> Bool {
        return false
    }
    
    func isValidPhoneNumber(text: String?) -> Bool {
        guard let value = text else {
            return false
        }
        return matchesPattern(text: value, patter: "[0-9]{3}")
    
    }
    
    func isValidEmailAddress(text: String?) -> Bool {
        return false
    }
    
    func isValidUsername(text: String?) -> Bool {
        return false
    }
    
    func isValidPassword(text: String?) -> Bool {
        return false
    }
    
    private func matchesPattern(text: String, patter: String) -> Bool {
        let result = text.range(of: patter, options: .regularExpression)
        guard let matches = result else {
            return false
        }
        return !matches.isEmpty
    }
    
    
}
