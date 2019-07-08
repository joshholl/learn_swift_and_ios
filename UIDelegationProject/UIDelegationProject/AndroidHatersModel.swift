//
//  AndroidHaterModel.swift
//  UIDelegationProject
//
//  Created by Josh Hollandsworth on 7/2/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation

struct AndroidHaterModel {
    var name: String
    var phoneNumber: String
    var emailAddress: String
    var username: String
    var password: String
    
    var displayable: String {
        return "🍏 Name: \(name), phone \(phoneNumber), email \(emailAddress), username \(username), password \(password)"
    }
   
    private static func hasMiniumLength(text: String?, isAtLeast minLength: Int) -> Bool {
        guard let target = text else {
            return false
        }
        return target.count >= minLength
    }
    static func isValidName(text: String?) -> Bool {
        return hasMiniumLength(text: text, isAtLeast: 3)
    }
    
    static func isValidPhoneNumber(text: String?) -> Bool {
        guard let value = text, let matches = value.range(of: "^[0-9]{10}$", options: .regularExpression) else {
            return false
        }
        return !matches.isEmpty
        
    }
    
    static func isValidEmailAddress(text: String?) -> Bool {
        return hasMiniumLength(text: text, isAtLeast: 3) && text!.contains("@")
    }
    
    static func isValidUsername(text: String?) -> Bool {
        return hasMiniumLength(text: text, isAtLeast: 3)
    }
    
    static func isValidPassword(text: String?) -> Bool {
        return hasMiniumLength(text: text, isAtLeast: 7)
    }
}




protocol AndroidHatersDelegate: class {
    func onSaved()
    func onCanSave(canSave: Bool)
}





public class AndroidHatersModel {
    private var haters: [AndroidHaterModel] = []
    private weak var delegate: AndroidHatersDelegate!
    
    private func hasMiniumLength(target: String?, minimum: Int) -> Bool {
        guard let value = target else {
            return false
        }
        return value.count >= minimum
    }
    
    var name: String? {
        didSet {
            checkIfCanSave()
        }
    }
    var phoneNumber: String?{
        didSet {
            checkIfCanSave()
        }
    }
    var email: String?{
        didSet {
            checkIfCanSave()
        }
    }
    var username: String?{
        didSet {
            checkIfCanSave()
        }
    }
    var password: String?{
        didSet {
            checkIfCanSave()
        }
    }
    
    init(delegate: AndroidHatersDelegate) {
        self.delegate = delegate
    }
    
    
    func addHater() {
        haters.append(AndroidHaterModel(name: name!, phoneNumber: phoneNumber!, emailAddress: email!, username: username!, password: password!))
        name = nil
        phoneNumber = nil
        email = nil
        username = nil
        password = nil
        self.delegate.onSaved()
    }
    
    func hatersAsString() -> String {
         return haters.map{ $0.displayable }.joined(separator: "\n")
    }
    
    private func checkIfCanSave() {
        let canSave =  [name, email, phoneNumber, username, password].allSatisfy{ $0 != nil }
        delegate.onCanSave(canSave: canSave)
    }
}



extension AndroidHatersModel {
    

    
   
}
