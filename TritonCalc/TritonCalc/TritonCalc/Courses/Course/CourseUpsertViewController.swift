import Foundation
import UIKit

class CourseUpsertViewController: UIViewController {
    
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var creditHourStepper: UIStepper!
    @IBOutlet weak var creditHourStepperLabel: UILabel!
    @IBOutlet weak var projectedGradeTextField: UITextField!
    
    @IBOutlet weak var isSubstituteSwitch: UISwitch!
    @IBOutlet weak var previousGradeTextField: UITextField!

    @IBOutlet weak var saveButton: UIButton!
    
    private var projectedGradePicker: UIPickerView!
    private var previousGradePicker: UIPickerView!
    private var model: CourseUpsertModel!
    
}

// MARK: View Load
extension CourseUpsertViewController   {
    override func viewDidLoad() {
        // MARK: Course Name
        courseNameTextField.delegate = self
        courseNameTextField.text = model.name
        
        // MARK: Credit Hour Stepper
        creditHourStepper.minimumValue = model.minCourseHoursStepper
        creditHourStepper.maximumValue = model.maxCourseHoursStepper
        creditHourStepper.value = Double(model.hours ?? model.courseHoursStepperDefault)
        creditHourStepper.stepValue = model.courseHoursStepperSize
        creditHourStepperLabel.text = "\(Int(creditHourStepper.value))"
        
        // MARK: Grade Picker
        projectedGradePicker = UIPickerView()
        projectedGradePicker.delegate = self
        projectedGradePicker.dataSource = self
        projectedGradeTextField.inputView = projectedGradePicker
        projectedGradeTextField.delegate = self

        let projectedRow = model!.selectedLetterGradeIndex(isForSubstitution: false)
        projectedGradePicker.selectRow(projectedRow, inComponent: 0, animated: true)
        pickerView(projectedGradePicker, didSelectRow: projectedRow, inComponent: 0)


        // MARK: Previous Grade Picker
        previousGradePicker = UIPickerView()
        previousGradePicker.delegate = self
        previousGradePicker.dataSource = self
        previousGradeTextField.inputView = previousGradePicker
        previousGradeTextField.isEnabled =  false
        previousGradeTextField.delegate = self
        

        let previousGradeRow = model!.selectedLetterGradeIndex(isForSubstitution: true)
        previousGradePicker.selectRow(previousGradeRow, inComponent: 0, animated: true)
        pickerView(previousGradePicker, didSelectRow: previousGradeRow, inComponent: 0)

        
        //MARK: Substitute Switch Setup
        isSubstituteSwitch.setOn(model?.isSubstitute ?? false, animated: false)
        isSubstituteSwitch.isEnabled = model.projectedGrade != nil && model.projectedGrade != model.noneGradeValue
        
        
        self.saveButton.setTitle(model.saveButtonText, for: .normal)
    }
}

// MARK: Segue Setup
extension CourseUpsertViewController {
    func `for`(model: CourseUpsertModel) {
        self.model = model
    }
}

// MARK: Actions
extension CourseUpsertViewController {
    @IBAction private func courseHoursChanged(_ sender: UIStepper) {
        creditHourStepperLabel.text = "\(Int(sender.value))"
        model.hours = Int(sender.value)
    }
    
    @IBAction private func addCourseTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let validModel = model  else {
            return
        }
        if(validModel.canSave()) {
            validModel.save()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func isSubstitueChanged(_ sender: Any) {
        previousGradeTextField.isEnabled = isSubstituteSwitch.isOn
        model.isSubstitute = isSubstituteSwitch.isOn
        if(!previousGradeTextField.isEnabled) {
            previousGradeTextField.text = nil
            model.previousGrade = nil
        }
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        let value = sender.text
        
        switch sender {
        case courseNameTextField:
            model?.name = value
            sender.textColor = model!.isNameValid(value) ? UIColor.black :  UIColor(named: "UmslRed")
        case projectedGradeTextField:
            model?.projectedGrade = nilIfNone(value: value)
        case previousGradeTextField:
            let value = sender.text
            model?.previousGrade = nilIfNone(value: value)
            sender.textColor = model!.isPreviousGradeValid(value) ? UIColor.black :  UIColor(named: "UmslRed")
        default:
            break
        }
    }
   
}

// MARK: Text Field Delegate
extension CourseUpsertViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case previousGradeTextField:
            if(model.replaceableLetterGrades.contains(previousGradeTextField.text ?? "")) {
                return true
            } else {
                let row = model!.selectedLetterGradeIndex(isForSubstitution: true)
                selectPreviousGrade(row: row)
                return false
            }
        case projectedGradeTextField:
            if(model.letterGrades.contains(previousGradeTextField.text ?? "")) {
                return true
            } else {
                let row = model!.selectedLetterGradeIndex(isForSubstitution: false)
                selectProjectedGrade(row: row)
                return false
            }
        
        default:
            self.view.endEditing(true)
            return true
        
        
        }
    }
}

// MARK: Picker Delegate
extension CourseUpsertViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == self.previousGradePicker
            ? model.replaceableLetterGrades[row]
            : model.letterGrades[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.previousGradePicker {
            selectPreviousGrade(row: row)
        } else {
            selectProjectedGrade(row: row)
        }
        self.view.endEditing(true)
    }
    
    private func selectPreviousGrade(row: Int) {
        let letterGradeText = model.replaceableLetterGrades[row]
        previousGradeTextField.text = letterGradeText
        model.previousGrade = nilIfNone(value: letterGradeText)
        previousGradeTextField.isEnabled = true
    }
    
    private func selectProjectedGrade(row: Int) {
        let letterGradeText = model.letterGrades[row]
        projectedGradeTextField.text = letterGradeText
        model.projectedGrade = nilIfNone(value: letterGradeText)
        isSubstituteSwitch.isEnabled = model.projectedGrade != nil
    }
}

// MARK: Picker Datasource
extension CourseUpsertViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == self.previousGradePicker
            ? model.replaceableLetterGrades.count
            : model.letterGrades.count
    }
}

extension CourseUpsertViewController {
    func nilIfNone(value: String?) -> String? {
        if(value == model.noneGradeValue) {
            return nil
        }
        return value
    }
}
