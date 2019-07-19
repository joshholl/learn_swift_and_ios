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
    private(set) var isEdit: Bool
    private weak var delegate: WorkoutCreationModelDelegate?
        
    init(workout: Workout?, delegate: WorkoutCreationModelDelegate) {
        self.workout = workout ?? Workout.defaultWorkout
        self.delegate = delegate
        self.isEdit = workout != nil
    }
}

extension WorkoutCreationModel {
    func saveWorkout(name: String, date: Date, duration: Int, caloriesBurnedPerMinute: Double) {
        let updatedWorkout = Workout.fromWorkout(workout: self.workout,
                                          newName: name,
                                          newDate: date,
                                          newDuration: duration,
                                          newCaloriesBurnedPerMinute: caloriesBurnedPerMinute)
        delegate?.save(workout: updatedWorkout)
    }
}
