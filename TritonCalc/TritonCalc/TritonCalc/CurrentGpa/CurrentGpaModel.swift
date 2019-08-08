import Foundation

final class CurrentGpaModel {
    private var persistence: TritonCalcPersistence
    private weak var delegate: ModelRefreshDelegate?
    
    var hours : Int?
    var average: Double?
    
    init(gpa: GradePointAverage?, persistence: TritonCalcPersistence, delegate: ModelRefreshDelegate) {
        self.persistence = persistence
        self.delegate = delegate
        hours = gpa?.hours
        average = gpa?.average
    }
    
    func isAverageValid(_ average: Double? ) -> Bool {
        guard let value = average else {
            return false
        }
        return value >= 0 && value <= 4
    }
    
    
    func areHoursValid(_ hours: Int?) -> Bool {
        guard let value = hours else {
            return false
        }
        return value >= 0 && value <= 160
    }

    func canSave() -> Bool {
        return areHoursValid(self.hours) && isAverageValid(self.average)
    }
    
    func save() {
        let newGpa = GradePointAverage(hours: hours ?? 0, average: average ?? 0)
        persistence.save(gpa: newGpa)
        delegate?.refresh()
    }
    
}
