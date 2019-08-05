//
//  CourseUpsertViewController.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/4/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
import UIKit

class CourseUpsertViewController: UIViewController {
    
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var creditHourStepper: UIStepper!
    @IBOutlet weak var creditHourStepperLabel: UILabel!
    @IBOutlet weak var projectedGradeTextField: UITextField!

    private var projectedGradePicker: UIPickerView!
    private var model: CourseUpsertModel!
}

extension CourseUpsertViewController   {
    override func viewDidLoad() {

        //Course Name
        courseNameTextField.delegate = self
        courseNameTextField.text = model.course.name
        
        //Credit Hour Stepper
        creditHourStepper.minimumValue = model.minCourseHoursStepper
        creditHourStepper.maximumValue = model.maxCourseHoursStepper
        creditHourStepper.value = Double(model.course.creditHours)
        creditHourStepper.stepValue = model.courseHoursStepperSize
        creditHourStepperLabel.text = "\(Int(creditHourStepper.value))"
        
        // Grade Picker
        projectedGradePicker = UIPickerView()
        projectedGradePicker.delegate = self
        projectedGradePicker.dataSource = self
        projectedGradeTextField.inputView = projectedGradePicker
    }
}

extension CourseUpsertViewController {
    func `for`(model: CourseUpsertModel) {
        self.model = model
    }
}

extension CourseUpsertViewController {
    @IBAction private func courseHoursChanged(_ sender: UIStepper) {
        creditHourStepperLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction private func addCourseTapped(_ sender: UIButton) {
       model.save(name: courseNameTextField.text ?? "",
                  hours: Int(creditHourStepper.value),
                  grade: projectedGradeTextField.text ?? "")
        
        navigationController?.popViewController(animated: true)
    }
}


extension CourseUpsertViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension CourseUpsertViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.letterGrades[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        projectedGradeTextField.text = model.letterGrades[row]
        self.view.endEditing(true)
    }
}

extension CourseUpsertViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.letterGrades.count
    }

    
}
