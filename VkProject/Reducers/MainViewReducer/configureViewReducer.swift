import ReSwift

func configureViewReducer(action: Action, state: ConfigureViewState?) -> ConfigureViewState {
    var state = state ?? ConfigureViewState()
    
    switch action {
    case let action as StartModelingAction:
        state.tapped = action.tapped
        state.error = action.error
    default:
        break
    }
    
    return state
}
