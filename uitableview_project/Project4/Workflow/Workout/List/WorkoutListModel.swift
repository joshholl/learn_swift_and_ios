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
    
    func deleteAll()  {
        persistence?.removeAll()
        workouts = persistence?.savedWorkouts ?? []
        delegate?.dataRefreshed()
    }
}

extension WorkoutListModel: WorkoutCreationModelDelegate {
    func save(workout: Workout) {
        if let existingIndex = workouts.firstIndex(where: {(item) in item.id == workout.id}) {
            workouts.remove(at: existingIndex)
            workouts.insert(workout, at: existingIndex)
        } else {
                 workouts.append(workout)
        }
   
        persistence?.save(workout: workout)
        delegate?.dataRefreshed()
    }
}

extension WorkoutListModel: WorkoutListSortDelegate {
    func sort(withOption option: SortOption) {
        switch option {
        case .Duration:
            workouts.sort{a, b in a.duration > b.duration}
        case .CaloriesBurned:
            workouts.sort{a, b in a.caloriesBurned > b.caloriesBurned }
        case .DateAscending:
            workouts.sort{a, b in a.date < b.date}
        case .DateDescending:
            workouts.sort{a, b in a.date > b.date}
        }
        delegate?.dataRefreshed()
    }
}
