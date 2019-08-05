import Foundation
import UIKit

final class CourseListTableViewCell : UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var creditHours: UILabel!
    @IBOutlet private weak var letterGrade: UILabel!
    @IBOutlet private weak var points: UILabel!
    
    
    private(set) var course: Course!
    
    func forCourse(_ course: Course) {
        self.course = course
        
        nameLabel.text = course.name
        creditHours.text = "\(course.creditHours)"
        points.text = course.points.asString()
        
        guard let grade = course.grade?.rawValue else {
                return
        }
        
        self.letterGrade.text = String(format: "%g", grade.pointValue)
    }
    
}
