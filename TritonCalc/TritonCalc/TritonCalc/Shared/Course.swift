import Foundation

struct Course {
    
    let id: UUID
    let name: String
    let creditHours: Int
    let isSubstitue: Bool?
    let grade: LetterGrade?
    let previousGrade: LetterGrade?
}

extension Course {
    var points: Double {
        get {
            guard let pointValue = self.grade?.rawValue.pointValue else {
                return 0
            }
            
            return Double(creditHours) * pointValue
        }
    }
    
    var previousPoints: Double {
        get {
            guard let pointValue = self.previousGrade?.rawValue.pointValue else {
                return 0
            }
            return Double(creditHours) * pointValue
        }
    }
}

extension Course {
    static func from(_ courseEntities: [CourseEntity]) -> [Course] {
        return courseEntities.compactMap { Course.from($0) }
    }
    
    static func from(_ courseEntity: CourseEntity) -> Course? {
        guard let id = courseEntity.id else { return nil }
        guard let name = courseEntity.name else { return nil }
        
        let creditHours = Int(courseEntity.creditHours)
        let isSubstitue = courseEntity.isSubstitute
        let letterGrade = LetterGrade.from(string: courseEntity.letterGrade)
        let previousLetterGrade = LetterGrade.from(string: courseEntity.previousLetterGrade)
        
        return Course(id: id, name: name, creditHours: creditHours, isSubstitue: isSubstitue, grade: letterGrade, previousGrade: previousLetterGrade)
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

