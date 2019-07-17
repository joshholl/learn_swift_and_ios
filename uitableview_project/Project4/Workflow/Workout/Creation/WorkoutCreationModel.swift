import Foundation

protocol WorkoutCreationModelDelegate: class {
    func save(workout: Workout)
}

final class WorkoutCreationModel {
    let minimumStepperValue: Double = 2.0
    let maximumStepperValue: Double = 90.0
    
    private(set) var workout: Workout
    
    private weak var delegate: WorkoutCreationModelDelegate?
        
    init(workout: Workout, delegate: WorkoutCreationModelDelegate) {
        self.workout = workout
        self.delegate = delegate
    }
}

extension WorkoutCreationModel {
    func saveWorkout(name: String, date: Date, duration: Int, isHighIntensity: Bool) {
        delegate?.save(workout:
            Workout(
                id: workout.id,
                name: name.isEmpty ? workout.name : name,
                date: date,
                duration: duration,
                isHighIntensity: isHighIntensity
            )
        )
    }
}
