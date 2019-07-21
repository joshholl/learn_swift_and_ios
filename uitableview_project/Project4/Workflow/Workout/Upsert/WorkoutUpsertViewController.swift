import UIKit

final class WorkoutUpsertViewController: UIViewController {
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var dateField: UITextField!
    @IBOutlet private weak var minutesLabel: UILabel!
    @IBOutlet private weak var minutesStepper: UIStepper!
    @IBOutlet private weak var caloriesBurnedLabel: UILabel!
    @IBOutlet private weak var caloriesBurnedStepper: UIStepper!
    @IBOutlet private weak var addWorkoutButton: UIButton!
    
    private var datePicker: UIDatePicker!
    
    private var model: WorkoutUpsertModel!
}

extension WorkoutUpsertViewController {
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
        minutesStepper.minimumValue = model.minimumDurationStepperValue
        minutesStepper.maximumValue = model.maximumDurationStepperValue
        minutesStepper.value = Double(model.workout.duration)
        minutesLabel.text = "\(model.workout.duration)"

        //Configure calories per minute stepper and label
        caloriesBurnedStepper.maximumValue = model.maximumCaloriesBurnedStepperValue
        caloriesBurnedStepper.minimumValue = model.minimumCaloriesBurnedStepperValue
        caloriesBurnedStepper.value = Double(model.workout.caloriesBurnedPerMinute)
        caloriesBurnedLabel.text = String(format: "%.1f", model.workout.caloriesBurnedPerMinute)

        //set the button text for the add/edit workout button
        self.title = model.actionName
        self.addWorkoutButton.setTitle(model.actionName, for: .normal)
    }
}

extension WorkoutUpsertViewController {
    func setup(model: WorkoutUpsertModel) {
        self.model = model
    }
}

extension WorkoutUpsertViewController {
    @IBAction private func minutesValueChanged(_ sender: UIStepper) {
        minutesLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction private func caloriesPerMinuiteValueChanged(_ sender: UIStepper) {
        caloriesBurnedLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction private func addWorkoutButtonTapped(_ sender: UIButton) {
        model.saveWorkout(
            name: nameField.text ?? "",
            date: datePicker.date,
            duration: Int(minutesStepper.value),
            caloriesBurnedPerMinute: caloriesBurnedStepper.value
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

extension WorkoutUpsertViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
