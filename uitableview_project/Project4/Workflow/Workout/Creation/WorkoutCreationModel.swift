import Foundation

protocol WorkoutCreationModelDelegate: class {
    func save(workout: Workout)
}

final class WorkoutCreationModel {
    let minimumDurationStepperValue: Double = 2.0
    let maximumDurationStepperValue: Double = 90.0
    
    let minimumCaloriesBurnedStepperValue: Double = 1.0
    let maximumCaloriesBurnedStepperValue: Double = 20.0
    
    private(set) var workout: Workout
    
    private weak var delegate: WorkoutCreationModelDelegate?
        
    init(workout: Workout, delegate: WorkoutCreationModelDelegate) {
        self.workout = workout
        self.delegate = delegate
    }
}

extension WorkoutCreationModel {
    func saveWorkout(name: String, date: Date, duration: Int, caloriesBurnedPerMinute: Double) {
        delegate?.save(workout:
            Workout(
                id: workout.id,
                name: name.isEmpty ? workout.name : name,
                date: date,
                duration: duration,
                caloriesBurnedPerMinute: caloriesBurnedPerMinute
            )
        )
    }
}
