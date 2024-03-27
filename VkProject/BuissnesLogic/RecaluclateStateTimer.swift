import Foundation
import ReSwift

class StateRecalculationTimer {
    
    static let shared = StateRecalculationTimer()
    
    private var timer: Timer?
    private var timeInterval: TimeInterval
    
    private let backgroundQueue = DispatchQueue(label: "stateRecalculation", qos: .background)

    init() {
        self.timeInterval = 0
    }
    
    func updateTimeInterval(to newTimeInterval: TimeInterval) {
        timeInterval = newTimeInterval
        start()
    }
    
    func start() {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
            self?.backgroundQueue.async {
                let valuesForRecalculate: [Int] = mainStore.state.peopleIlnessState.infectionPeopleIndexes
                
                for index in valuesForRecalculate {
                    mainStore.dispatch(SpreadVirusAction(index: index))
                }
                
                let currentCellStates = mainStore.state.peopleIlnessState.people
                let currentInfectedCount = mainStore.state.peopleIlnessState.infectionCount
                let currentIndexesIllnes = mainStore.state.peopleIlnessState.infectionPeopleIndexes
                
                var updatedCellStates = currentCellStates
                var newInfectedCount = currentInfectedCount
                var updatedIndexesIllnes = currentIndexesIllnes
                
                DispatchQueue.global().async {
                    let randomInfectedNeighborsCount = Int.random(in: 1...valuesForRecalculate.count)
    
                    for _ in 0..<randomInfectedNeighborsCount {
                        let index = valuesForRecalculate.randomElement() ?? 0
                        spreadInfection(around: index, people: &updatedCellStates, infectionFactor: mainStore.state.modelingParametrsState.infectionFactor, infectedCount: &newInfectedCount, infectedIndexes: &updatedIndexesIllnes)
                    }
                    
                    DispatchQueue.main.async {
                        mainStore.dispatch(UpdateValuesIllnesAction(illnesCount: newInfectedCount, people: updatedCellStates, illnesPeopleIndex: updatedIndexesIllnes))
                    }
                }
            }
            
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
