import Foundation



public struct Course {
    let name: String
    let creditHours: Int
    let grade: LetterGrade
    var isProjected: Bool
    
    var points: Double {
        return Double(creditHours) * grade.rawValue.pointValue
    }
    
}


struct Grade {
    let letter: String
    let pointValue: Double
}



enum LetterGrade: RawRepresentable, CaseIterable {
    case A, AMinus, BPlus, B, BMinus, CPlus, C, CMinus,DPlus, D, DMinus, F, FN
    
    var rawValue: Grade {
        switch self {
        case .A: return Grade(letter: "A", pointValue: 4 )
        case .AMinus: return Grade(letter: "A-", pointValue: 3.7)
        case .BPlus: return Grade(letter: "B+", pointValue: 3.3)
        case .B: return Grade(letter: "B", pointValue: 3)
        case .BMinus: return Grade(letter: "B-", pointValue: 2.7)
        case .CPlus: return Grade(letter: "C+", pointValue: 2.3)
        case .C: return Grade(letter: "C", pointValue: 2)
        case .CMinus: return Grade(letter: "C-", pointValue: 1.7)
        case .DPlus: return Grade(letter: "D+", pointValue: 1.3)
        case .D: return Grade(letter: "D", pointValue: 1)
        case .DMinus: return Grade(letter: "D-", pointValue: 0.7)
        case .F: return Grade(letter: "F", pointValue: 0)
        case .FN :return Grade(letter: "FN", pointValue: 0)
        }
    }
    
    init?(rawValue: Grade) {
        switch rawValue.letter {
        case "A": self = .A
        case "AMinus": self = .AMinus
        case "BPlus": self = .BPlus
        case "B": self = .B
        case "BMinus": self = .BMinus
        case "CPlus": self = .CPlus
        case "C": self = .C
        case "CMinus": self = .CMinus
        case "DPlus": self = .DPlus
        case "D": self = .D
        case "DMinus": self = .DMinus
        case "F": self = .F
        case "FN": self = .FN
        default: return nil
        }
    }
    
}
