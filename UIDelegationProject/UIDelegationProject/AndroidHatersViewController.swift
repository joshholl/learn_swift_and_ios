import UIKit

class AndroidHatersViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var haterTextField: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func onJoinPressed(_ sender: Any) {
        model.addHater()
    }
    
    private var textFields: [UITextField] = []
    private var model: AndroidHatersModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = AndroidHatersModel(delegate: self)
        
        textFields = [nameTextField, emailAddressTextField, phoneNumberTextField, usernameTextField, passwordTextField ]
        textFields.forEach{ $0.enablesReturnKeyAutomatically = true}
        
        
        nameTextField.delegate = self
        emailAddressTextField.delegate = self
        phoneNumberTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate  = self
    }
    
}

extension AndroidHatersViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            emailAddressTextField.becomeFirstResponder()
        case emailAddressTextField:
            usernameTextField.becomeFirstResponder()
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            addButton.becomeFirstResponder()
        case addButton:
            nameTextField.becomeFirstResponder()
        default:
            self.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        return false
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameTextField:
            if AndroidHaterModel.isValidName(text: textField.text) {
                model.name = textField.text
                textField.textColor = UIColor.black
                return true
            }
        case emailAddressTextField:
            if AndroidHaterModel.isValidEmailAddress(text: textField.text) {
                model.email = textField.text
                textField.textColor = UIColor.black
                return true
            }
        case phoneNumberTextField:
            
            
            if AndroidHaterModel.isValidPhoneNumber(text: textField.text) {
                model.phoneNumber = textField.text
                textField.textColor = UIColor.black
                return true
            }
        case usernameTextField:
            if AndroidHaterModel.isValidUsername(text: textField.text) {
                model.username = textField.text
                textField.textColor = UIColor.black
                return true
            }
        case passwordTextField:
            if AndroidHaterModel.isValidPassword(text: textField.text) {
                model.password = textField.text
                textField.textColor = UIColor.black
                return true
            }
        default:
            return true
        }
        
        textField.textColor = UIColor.red
        return false
    }
}


extension AndroidHatersViewController : AndroidHatersDelegate {
    func onSaved() {
        textFields.forEach{$0.text = nil}
        haterTextField.text = model.hatersAsString()
    }
    
    func onCanSave(canSave: Bool) {
        addButton.isEnabled = canSave
    }
}
