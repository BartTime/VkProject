import ReSwift

struct AppState {
    var configureViewState: ConfigureViewState
    var modelingParametrsState: ModellingParametrsState
    var peopleIlnessState: PeopleIlnessState
    var recalculateState: RecalculateState
}

struct ConfigureViewState: Equatable {
    var tapped: Bool = false
    var error: ErrorWithCheckParams?
}

struct ModellingParametrsState: Equatable {
    var valueGroupSize: Int = 0
    var infectionFactor: Int = 0
    var time: Int = 0
}

struct PeopleIlnessState{
    var people: [People] = []
    var infectionCount: Int = 0
    var infectionPeopleIndexes: [Int] = []
}

struct People {
    var isInfected: Bool = false
    var name: String
    var image: String
}

struct RecalculateState {
    var activate: Bool = false
}


