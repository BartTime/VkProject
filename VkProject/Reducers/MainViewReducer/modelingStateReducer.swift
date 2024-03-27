import ReSwift

func modelingStateReducer(action: Action, state: ModellingParametrsState?) -> ModellingParametrsState {
    var state = state ?? ModellingParametrsState()
    
    switch action {
    case let action as PushModellingParametes:
        state.valueGroupSize = action.valueGroupSize ?? 0
        state.infectionFactor = action.infectionFactor ?? 0
        state.time = action.time ?? 0
    default:
        break
    }
    
    return state
}
