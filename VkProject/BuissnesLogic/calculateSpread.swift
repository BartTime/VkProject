import Foundation

func spreadInfection(around personIndex: Int, people: inout [People], infectionFactor: Int, infectedCount: inout Int, infectedIndexes: inout [Int]) {
    var neighboringIndices = Set<Int>()
    
    while neighboringIndices.count < infectionFactor {
        if let neighborIndex = findUninfectedNeighborIndex(from: personIndex, with: infectionFactor, in: people, infectedIndexes: infectedIndexes) {
            neighboringIndices.insert(neighborIndex)
        } else {
            break // Прерываем цикл, если не удается найти новые индексы
        }
    }
    
    for index in neighboringIndices {
        people[index].isInfected = true
        people[index].image = "illPerson"
        infectedCount += 1
        infectedIndexes.append(index)
    }
}

func findUninfectedNeighborIndex(from personIndex: Int, with infectionFactor: Int, in people: [People], infectedIndexes: [Int]) -> Int? {
    let numberOfPeople = people.count
    
    var availableOffsets = Set(ValuesConstant.minValue.rawValue...ValuesConstant.maxValue.rawValue)
    availableOffsets.remove(0) // Удаляем 0, чтобы не пытаться выбирать текущего человека
    
    for _ in 0..<infectionFactor {
        guard let randomIndexOffset = availableOffsets.randomElement() else {
            return nil
        }
        
        let newIndex = personIndex + randomIndexOffset
        if newIndex >= 0 && newIndex < numberOfPeople && !infectedIndexes.contains(newIndex) {
            return newIndex
        }
        availableOffsets.remove(randomIndexOffset)
    }
    return nil
}


fileprivate enum ValuesConstant: Int {
    case maxValue = 5
    case minValue = -5
}
