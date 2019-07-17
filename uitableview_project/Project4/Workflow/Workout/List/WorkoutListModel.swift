import Foundation
import struct UIKit.CGFloat

protocol WorkoutListModelDelegate: class {
    func dataRefreshed()
}

final class WorkoutListModel {
    private let persistence: WorkoutPersistenceInterface?
    private var workouts: [Workout]
    
    private weak var delegate: WorkoutListModelDelegate?
    
    let rowHeight: CGFloat = 64.0
    
    var count: Int { return workouts.count }
    
    init(delegate: WorkoutListModelDelegate) {
        self.delegate = delegate
        
        let persistence = ApplicationSession.sharedInstance.persistence
        self.persistence = persistence
        workouts = persistence?.savedWorkouts ?? []
    }
}

extension WorkoutListModel {
    func workout(atIndex index: Int) -> Workout? {
        return workouts.element(at: index)
    }
}

extension WorkoutListModel: WorkoutCreationModelDelegate {
    func save(workout: Workout) {
        workouts.append(workout)
        persistence?.save(workout: workout)
        delegate?.dataRefreshed()
    }
}
