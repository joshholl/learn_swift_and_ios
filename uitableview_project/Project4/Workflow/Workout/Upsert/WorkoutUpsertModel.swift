import Foundation

protocol WorkoutUpsertModelDelegate: class {
    func save(workout: Workout)
}

final class WorkoutUpsertModel {
    let minimumDurationStepperValue: Double = 2.0
    let maximumDurationStepperValue: Double = 90.0
    
    let minimumCaloriesBurnedStepperValue: Double = 1.0
    let maximumCaloriesBurnedStepperValue: Double = 20.0
    
    private(set) var workout: Workout
    private(set) var actionName: String
    private weak var delegate: WorkoutUpsertModelDelegate?

    init(workout: Workout?, delegate: WorkoutUpsertModelDelegate) {
        self.workout = workout ?? Workout.defaultWorkout
        self.delegate = delegate
        actionName = workout != nil ? "Edit Workout" : "Add Workout"
    }
}

extension WorkoutUpsertModel {
    func saveWorkout(name: String, date: Date, duration: Int, caloriesBurnedPerMinute: Double) {
        let updatedWorkout = Workout.fromWorkout(workout: self.workout,
                                          newName: name,
                                          newDate: date,
                                          newDuration: duration,
                                          newCaloriesBurnedPerMinute: caloriesBurnedPerMinute)
        delegate?.save(workout: updatedWorkout)
    }
}
