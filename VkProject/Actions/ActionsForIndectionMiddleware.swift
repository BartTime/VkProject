import ReSwift

struct InfectPersonAction: Action {
    let index: Int
}

struct SpreadVirusAction: Action {
    let index: Int
}

struct PersonsPushToStateAction: Action {
    var groupSize: Int
}

struct UpdateValuesIllnesAction: Action {
    var illnesCount: Int
    var people: [People]
    var illnesPeopleIndex: [Int]
}

struct PersonToPeopleAction: Action {
    var people: [People]
}

struct RecalculateStateActivateAction: Action {
    
}

struct RecalculateStateChange: Action {
    var value: Bool
}

struct RecalculateStateStopAction: Action {
    
}

struct ClearStateForModellingAction: Action {
    
}

struct ClearStateAction: Action {
    
}
