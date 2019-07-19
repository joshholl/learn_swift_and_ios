import Foundation

struct Workout: Codable {
    let id: UUID
    let name: String
    let date: Date
    let duration: Int
    let caloriesBurnedPerMinute:Double
}

extension Workout {
    static var defaultWorkout: Workout {
        return Workout(id: UUID(), name: "No Name", date: Date(), duration: 10, caloriesBurnedPerMinute: 1)
    }
    static func fromWorkout(workout: Workout, newName: String?, newDate: Date?, newDuration: Int?, newCaloriesBurnedPerMinute: Double?) -> Workout {
        return Workout(id: workout.id,
                       name: newName ?? workout.name,
                       date: newDate ?? workout.date,
                       duration: newDuration ?? workout.duration,
                       caloriesBurnedPerMinute: newCaloriesBurnedPerMinute ?? workout.caloriesBurnedPerMinute)
    }
}
