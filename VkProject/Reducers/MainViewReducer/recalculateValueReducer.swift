import ReSwift

func recalculateValueReducer(action: Action, state: RecalculateState?) -> RecalculateState {
    var state = state ?? RecalculateState()
    
    switch action {
    case let updateValueRecalculate as RecalculateStateChange:
        state.activate = updateValueRecalculate.value
        StateRecalculationTimer.shared.stop()
    default:
        break
    }
    
    return state
}
