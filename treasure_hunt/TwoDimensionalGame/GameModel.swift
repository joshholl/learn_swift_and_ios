import Foundation

enum Direction: CaseIterable {
    case north, east, west, south
}

struct Coordinate : Equatable {
    let x: Int
    let y: Int
}

struct Location {
    let coordinate: Coordinate
    let allowedDirections: [Direction]
    var event: String?
}

struct Row {
    let locations: [Location]
}

class GameModel {
    private var grid = [Row]()
    private var treasureChests = [Coordinate]()
    private var foundTreasureChests = [Coordinate]()
    private var currentRowIndex = 2          // start at (x: 0, y: 0)
    private var currentLocationIndex = 2
    
    private let minXYvalue = -2
    private let maxXYvalue = 2
    
    init() {
        self.grid = createGameGrid()
        placeTreasureChests()
    }
}

// MARK: - Public facing methods
extension GameModel {
    
    func restart() {
        currentRowIndex = 2
        currentLocationIndex = 2
        
        treasureChests.removeAll()
        foundTreasureChests.removeAll()
        placeTreasureChests()
    }
    
    func chestHuntStatistics() -> (found: Int, total: Int ){
        return (found: foundTreasureChests.count, total: treasureChests.count)
    }
    
    func currentLocation() -> Location {
        
        var location =  grid[currentRowIndex].locations[currentLocationIndex]
        location.event = event(forCoordinate: location.coordinate)
        return location;
    }
    
    func move(direction: Direction) {
        switch direction {
        case .north:
            currentRowIndex -= 1
        case .south:
            currentRowIndex += 1
        case .east:
            currentLocationIndex += 1
        case .west:
            currentLocationIndex -= 1
        }
    }
}

// MARK: - Helper methods for creating grid
extension GameModel {
    
    private func placeTreasureChests() {
        let startPoint = Coordinate(x: 0, y: 0)
        let maxNumberOfChests = abs(minXYvalue) + maxXYvalue;
        var placementAttempts = 0
        
        let numberOfChests = (Int.random(in: 1...100) % maxNumberOfChests) + 1
        
        repeat {
            placementAttempts += 1
            let chestPosition = Coordinate(x: Int.random(in: minXYvalue...maxXYvalue), y: Int.random(in: minXYvalue...maxXYvalue))
            if(!treasureChests.contains(chestPosition) && chestPosition != startPoint ) {
                treasureChests.append(chestPosition)
            }
        } while treasureChests.count != numberOfChests && placementAttempts < (maxNumberOfChests * 50)
    }
    private func createGameGrid() -> [Row] {
        let possibleXYValues = Array(minXYvalue...maxXYvalue)
        let gameGrid: [Row] = possibleXYValues.map { yValue in
            let locations: [Location] = possibleXYValues.map { xValue in
                let coordinate = Coordinate(x: xValue, y: yValue)
                let allowedDirections = self.allowedDirections(forCoordinate: coordinate)
                
                
                return Location(coordinate: coordinate, allowedDirections: allowedDirections, event: nil)
            }
            
            return Row(locations: locations)
        }
        
        return gameGrid
    }
    
    private func allowedDirections(forCoordinate coordinate: Coordinate) -> [Direction] {
        var directions = [Direction]()
        
        switch coordinate.y {
        case minXYvalue: directions += [.south]
        case maxXYvalue: directions += [.north]
        default: directions += [.north, .south]
        }
        
        switch coordinate.x {
        case minXYvalue: directions += [.east]
        case maxXYvalue: directions += [.west]
        default: directions += [.east, .west]
        }
        
        return directions
    }
    
    private func event(forCoordinate coordinate: Coordinate) -> String? {
        if(treasureChests.contains(coordinate) && !foundTreasureChests.contains(coordinate)) {
            foundTreasureChests.append(coordinate)
            return "🎉You found a treasure chest🎉"
        }
        
        return nil
    }
}
