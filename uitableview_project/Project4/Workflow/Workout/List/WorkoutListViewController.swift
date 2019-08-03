import UIKit

final class WorkoutListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    

    private var model: WorkoutListModel!
}

extension WorkoutListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = WorkoutListModel(delegate: self)
    }
    @IBAction func doSort(_ sender: Any) {
        self.present(createAlertForSort(handler: model), animated: true)
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        self.present(createAlertForDeleteAll(handler: {(_) in self.model.deleteAll()}), animated: true)
        
    }
    
    func deleteWorkout(workout: Workout) {
        self.present(createAlertForDeleteWorkout(named: workout.name,  handler: { (_) in
            self.model.deleteWorkout(workout: workout)
        }), animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let creationViewController = segue.destination as? WorkoutUpsertViewController {
            let workout = sender as? Workout 
            let workoutCreationModel = WorkoutUpsertModel(workout: workout, delegate: model)
            creationViewController.setup(model: workoutCreationModel)
        }
    }
}

extension WorkoutListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutListTableViewCell
        cell.setup(with: model.workout(atIndex: indexPath.row)!)
        
        return cell
    }
}

extension WorkoutListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WorkoutListTableViewCell
        
        performSegue(withIdentifier: "WorkoutUpsert", sender: cell.workout)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let cell = tableView.cellForRow(at: indexPath) as! WorkoutListTableViewCell
            
            self.present(createAlertForDeleteWorkout(named: cell.workout.name, handler: { (_) in
                self.model.deleteWorkout(workout: cell.workout)
            }), animated: true)
        
        default:
            break
        }
    }
    
}

extension WorkoutListViewController: WorkoutListModelDelegate {
    func dataRefreshed() {
        tableView.reloadData()
    }
}
