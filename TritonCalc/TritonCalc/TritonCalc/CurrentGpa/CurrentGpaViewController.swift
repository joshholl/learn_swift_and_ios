//
//  CurrentGpaViewController.swift
//  TritonCalc
//
//  Created by Josh Hollandsworth on 8/4/19.
//  Copyright © 2019 Joshholl. All rights reserved.
//

import Foundation
import UIKit

class CurrentGpaViewController: UIViewController {
    private var model: GradePointAverage?
    private var updateDelegate: GpaOverviewDelegate?
    
    @IBOutlet private weak var numberOfHours: UITextField!
    @IBOutlet private weak var gpa: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
}

extension CurrentGpaViewController {
    
    override func viewDidLoad() {
        guard let currentModel = model else {
            model = GradePointAverage.default
            return
        }
        
        numberOfHours.text = "\(currentModel.hours)"
        gpa.text = currentModel.average.asString()
    }
   
    @IBAction private func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        guard let delegate = updateDelegate else {
            return
        }
        
        guard let hours = numberOfHours.text else {
            return
        }
        guard let average = gpa.text else {
            return
        }
        delegate.update(to: GradePointAverage(
            hours: Int(hours) ?? 0,
            average: Double(average) ?? 0
        ))
       
        dismiss(animated: true, completion: nil)
    }
}

extension CurrentGpaViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension CurrentGpaViewController {
    func prepare(model: GradePointAverage, delegate: GpaOverviewDelegate) {
        self.model = model
        self.updateDelegate = delegate
    }
}
