import Foundation

public struct Course {
    let name: String
    let creditHours: Int
    let grade: LetterGrade?
    let isSubstitue: Bool
    var points: Double {
        get {
        guard let pointValue = grade?.rawValue.pointValue else {
            return 0
        }
        return Double(creditHours) * pointValue
        }
    }
}

extension Course {
    static var `default`: Course {
        return Course(name: "", creditHours: 3, grade: nil, isSubstitue: false)
    }
}

extension Course: Equatable {
    public static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.name == rhs.name &&
            lhs.creditHours == rhs.creditHours &&
            lhs.grade == rhs.grade &&
            lhs.isSubstitue == rhs.isSubstitue
    }
}
