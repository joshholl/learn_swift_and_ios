//
//  ViewController.swift
//  UIDelegationProject
//
//  Created by Josh Hollandsworth on 7/2/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import UIKit

class AndroidHatersViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailAddressTextFiled: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!

    private var model: AndroidHatersModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        model = AndroidHatersModel(delegate: self)
        nameTextField.delegate = self
        emailAddressTextFiled.delegate = self
        phoneNumberTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate  = self
    
    }
    
    
    func validateTextField(label: UILabel, field: UITextField, validator: ValidatorFunction) {
        if(!validator(field.text)) {
            label.textColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            field.becomeFirstResponder()
        } else {
            label.textColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        }
    }
    
    func focusLabel(_ label: UILabel) {
        label.textColor = UIColor(named: "red")
    }
    

}

typealias ValidatorFunction = (_ text: String?) -> Bool

extension AndroidHatersViewController : AndroidHatersDelegate {
    func onSaved(haterInfo: String) {
        
    }
}

extension AndroidHatersViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case nameTextField: validateTextField(label: nameLabel, field: textField, validator: model.isValidName(text:))
        case emailAddressTextFiled: validateTextField(label: emailAddressLabel, field: textField, validator: model.isValidEmailAddress(text:))
        case phoneNumberTextField: validateTextField(label: phoneNumberLabel, field: textField, validator: model.isValidPhoneNumber(text:))
        case usernameTextField: validateTextField(label: usernameLabel, field: textField, validator: model.isValidUsername(text:))
        case passwordTextField: validateTextField(label: passwordLabel, field: textField, validator: model.isValidPassword(text:))
        default:
            return
        }
    }
}

