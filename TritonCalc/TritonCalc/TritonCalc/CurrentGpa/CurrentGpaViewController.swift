//
import Foundation
import UIKit

class CurrentGpaViewController: UIViewController {
    private var model: CurrentGpaModel?
    
    @IBOutlet private weak var hoursTextField: UITextField!
    @IBOutlet private weak var averageTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
}

extension CurrentGpaViewController {
    
    override func viewDidLoad() {
        hoursTextField.delegate = self
        averageTextField.delegate = self
        hoursTextField.text = "\(model?.hours ?? 0 )"
        averageTextField.text = String(format: "%.3g", model?.average ?? 0)
    }
    
    @IBAction private func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        guard let validModel = model  else {
            return
        }
        if(validModel.canSave()) {
            validModel.save()
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension CurrentGpaViewController: UITextFieldDelegate {
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        switch textField {
//        case hoursTextField:
//            averageTextField.becomeFirstResponder()
//            return true
//        case averageTextField:
//            saveButton.becomeFirstResponder()
//        default:
//            self.becomeFirstResponder()
//        }
//        textField.resignFirstResponder()
//        return false
//    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let validModel = model else {
            return true
        }
        
        guard let textValue = textField.text else {
            textField.textColor = UIColor(named: "UmslRed")
            return false
        }
        
        
        switch textField {
        case averageTextField :
            let value = Double(textValue)
            if validModel.isAverageValid(value) {
                validModel.average = value
                textField.textColor = UIColor.black
                return true
            }   
        case hoursTextField :
            let value = Int(textValue)
            if validModel.areHoursValid(value) {
                validModel.hours = value
                textField.textColor = UIColor.black
                return true
            }
        default:
            return true;
        }
        textField.textColor = UIColor(named: "UmslRed")
        return false
    }
}


extension CurrentGpaViewController {
    func prepare(model: CurrentGpaModel) {
        self.model = model
    }
}
