import ReSwift

struct StartModelingAction: Action {
    let tapped: Bool
    let error: ErrorWithCheckParams?
}

struct StartModelingActionTapped: Action {
    let tapped: Bool
    let valueGroupSize: String
    let infetionFactor: String
    let time: String
}

struct PushModellingParametes: Action {
    let valueGroupSize: Int?
    let infectionFactor: Int?
    let time: Int?
}
