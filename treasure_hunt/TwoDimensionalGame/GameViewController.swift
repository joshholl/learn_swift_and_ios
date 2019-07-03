import UIKit
import Foundation;

class GameViewController: UIViewController {
    
    @IBOutlet weak var lastMoveLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var treasureChestStats: UILabel!
    
    @IBOutlet weak var northButton: UIButton!
    @IBOutlet weak var southButton: UIButton!
    @IBOutlet weak var westButton: UIButton!
    @IBOutlet weak var eastButton: UIButton!
    
    var buttonMapping : [Direction: UIButton] = [:]
    let game : GameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonMapping = [ Direction.north: northButton, Direction.south : southButton,
                          Direction.east : eastButton, Direction.west: westButton]
        update("Which direction captain?")
    }
    
    @IBAction func onGoNorth(_ sender: UIButton) {
        move(toThe: Direction.north)
    }
    @IBAction func onGoSouth(_ sender: UIButton) {
        move(toThe: Direction.south)
    }
    @IBAction func onGoEast(_ sender: UIButton) {
        move(toThe: Direction.east)
    }
    @IBAction func onGoWest(_ sender: UIButton) {
        move(toThe: Direction.west)
    }
    @IBAction func onGameReset(_ sender: UIButton) {
        game.restart()
        update("Which direction captain?")
    }
    
    func move(toThe direction: Direction) {
        game.move(direction: direction)
        update("Moved \(direction)")
    }
    
    func update(_ message: String) {
        
        lastMoveLabel.text = message
        
        let nowAt =  game.currentLocation()
        currentLocationLabel.text = "(X: \(nowAt.coordinate.x), Y: \(nowAt.coordinate.y) )"
        
        let ( found, total) = game.chestHuntStatistics()
        treasureChestStats.text = "You have found \(found) of \(total) chests"
        
        eventLabel.text = nowAt.event
        buttonMapping.forEach{ $1.isEnabled = nowAt.allowedDirections.contains($0) }
    }
    
}
