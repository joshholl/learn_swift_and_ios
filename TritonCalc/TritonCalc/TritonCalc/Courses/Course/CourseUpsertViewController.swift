import Foundation
import UIKit

class CourseUpsertViewController: UIViewController {
    
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var creditHourStepper: UIStepper!
    @IBOutlet weak var creditHourStepperLabel: UILabel!
    @IBOutlet weak var projectedGradeTextField: UITextField!
    @IBOutlet weak var isSubstituteSwitch: UISwitch!
    
    @IBOutlet weak var saveButton: UIButton!
    private var projectedGradePicker: UIPickerView!
    private var model: CourseUpsertModel!
}

// MARK: View Load
extension CourseUpsertViewController   {
    override func viewDidLoad() {
        // MARK: Course Name
        courseNameTextField.delegate = self
        courseNameTextField.text = model.course?.name
        
        // MARK: Credit Hour Stepper
        creditHourStepper.minimumValue = model.minCourseHoursStepper
        creditHourStepper.maximumValue = model.maxCourseHoursStepper
        creditHourStepper.value = Double(model.course?.creditHours ?? 3)
        creditHourStepper.stepValue = model.courseHoursStepperSize
        creditHourStepperLabel.text = "\(Int(creditHourStepper.value))"
        
        // MARK: Grade Picker
        projectedGradePicker = UIPickerView()
        projectedGradePicker.delegate = self
        projectedGradePicker.dataSource = self
        projectedGradeTextField.inputView = projectedGradePicker
        let row = model!.selectedLetterGradeIndex()
       
        projectedGradePicker.selectRow(row, inComponent: 0, animated: true)
        pickerView(projectedGradePicker, didSelectRow: row, inComponent: 0)

        
        //MARK: Substitute Switch Setup
        isSubstituteSwitch.isOn = model.course?.isSubstitue ?? false
        isSubstituteSwitch.isEnabled = model.course?.grade != nil
        
    
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
    }
    
    @IBAction private func addCourseTapped(_ sender: UIButton) {
       model.save(name: courseNameTextField.text ?? "",
                  hours: Int(creditHourStepper.value),
                  grade: projectedGradeTextField.text ?? "",
                    isSubstitue: isSubstituteSwitch.isOn)
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Text Field Delegate
extension CourseUpsertViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

// MARK: Picker Delegate
extension CourseUpsertViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.letterGrades[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let letterGradeText = model.letterGrades[row]
        projectedGradeTextField.text = letterGradeText
        isSubstituteSwitch.isEnabled = letterGradeText != "NONE"
        self.view.endEditing(true)
    }
}

// MARK: Picker Datasource
extension CourseUpsertViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.letterGrades.count
    }

    
}
