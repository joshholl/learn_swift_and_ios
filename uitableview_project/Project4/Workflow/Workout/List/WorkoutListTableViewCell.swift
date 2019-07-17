import UIKit

final class WorkoutListTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var caloriesPerMinuteLabel: UILabel!
    
    private(set) var workout: Workout!
    
    func setup(with workout: Workout) {
        self.workout = workout
        
        nameLabel.text = workout.name
        dateLabel.text = workout.date.toString(format: .yearMonthDay)
        durationLabel.text = "\(workout.duration) minutes"
        caloriesPerMinuteLabel.text = String(format: "%.1f Cal/Min", workout.caloriesBurnedPerMinute)
    }
}
