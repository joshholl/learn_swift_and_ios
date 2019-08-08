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
        
        hoursTextField.text = "\(model?.hours ?? 0)"
        averageTextField.text = String(format: "%.3g", model?.average ?? 0)
    }
    
    @IBAction private func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        switch sender {
        case hoursTextField:
            let value = Int(sender.text ?? "")
            model?.hours = value
            sender.textColor = model!.areHoursValid(value) ? UIColor.black :  UIColor(named: "UmslRed")
        case averageTextField:
            let value = Double(sender.text ?? "")
            model?.average = value
            sender.textColor = model!.isAverageValid(value) ? UIColor.black :  UIColor(named: "UmslRed")
        default:
            break
        }
    }
    
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        
        self.view.endEditing(true)
        guard let validModel = model  else {
            return
        }
        if(validModel.canSave()) {
            validModel.save()
            dismiss(animated: true, completion: nil)
        }
        
        
    }
}

extension CurrentGpaViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case hoursTextField:
            averageTextField.becomeFirstResponder()
            return true
        case averageTextField:
            saveButton.becomeFirstResponder()
        default:
            self.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if model != nil {
            return true
        }
        
        guard textField.text != nil else {
            return false
        }
        
        switch textField {
        case hoursTextField:
            let value = Int(textField.text ?? "")
            model?.hours = value
            return model!.areHoursValid(value)
        case averageTextField:
            let value = Double(textField.text ?? "")
            model?.average = value
            return model!.isAverageValid(value)
        default:
            return true
        }
    }
}


extension CurrentGpaViewController {
    func prepare(model: CurrentGpaModel) {
        self.model = model
    }
}
