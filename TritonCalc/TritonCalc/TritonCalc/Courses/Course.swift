import Foundation



public struct Course {
    let name: String
    let creditHours: Int
    let grade: LetterGrade?
    var points: Double {
        guard let pointValue = grade?.rawValue.pointValue else {
            return 0
        }
        return Double(creditHours) * pointValue
    }
}

extension Course {
    static var `default`: Course {
        return Course(name: "", creditHours: 3, grade: nil)
    }
}