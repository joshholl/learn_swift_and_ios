import UIKit

final class WorkoutCreationViewController: UIViewController {
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var dateField: UITextField!
    @IBOutlet private weak var minutesLabel: UILabel!
    @IBOutlet private weak var minutesStepper: UIStepper!
    @IBOutlet private weak var highIntensitySwitch: UISwitch!
    @IBOutlet private weak var addWorkoutButton: UIButton!
    
    private var datePicker: UIDatePicker!
    
    private var model: WorkoutCreationModel!
}

extension WorkoutCreationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure date picker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        datePicker.date = model.workout.date
        // A selector is much like an IBAction. It sends an event message to a target
        // when that event is triggered
        datePicker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        
        // Configure text fields
        dateField.inputView = datePicker   // use picker as input view
        dateField.text = datePicker.date.toString(format: .yearMonthDay)  // uses toString() extension I made
        nameField.text = model.workout.name
        
        // Configure minutes stepper and label
        minutesStepper.minimumValue = model.minimumStepperValue
        minutesStepper.maximumValue = model.maximumStepperValue
        minutesStepper.value = Double(model.workout.duration)
        minutesLabel.text = "\(model.workout.duration)"
        
        // Turn off switch by default
        highIntensitySwitch.isOn = model.workout.isHighIntensity
    }
}

extension WorkoutCreationViewController {
    func setup(model: WorkoutCreationModel) {
        self.model = model
    }
}

extension WorkoutCreationViewController {
    @IBAction private func minutesValueChanged(_ sender: UIStepper) {
        minutesLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction private func addWorkoutButtonTapped(_ sender: UIButton) {
        model.saveWorkout(
            name: nameField.text ?? "",
            date: datePicker.date,
            duration: Int(minutesStepper.value),
            isHighIntensity: highIntensitySwitch.isOn
        )
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)  // this actually loops through all this view's subviews and resigns the first responder on all of them
    }
    
    @objc private func dateValueChanged() {
        dateField.text = datePicker.date.toString(format: .yearMonthDay)
    }
}

extension WorkoutCreationViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
