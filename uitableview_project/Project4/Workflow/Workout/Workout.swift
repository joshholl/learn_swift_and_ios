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
}
