import ReSwift


func rootReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState(
        configureViewState: ConfigureViewState(),
        modelingParametrsState: ModellingParametrsState(),
        peopleIlnessState: PeopleIlnessState(),
        recalculateState: RecalculateState()
    )
    
    state.configureViewState = configureViewReducer(action: action, state: state.configureViewState)
    state.modelingParametrsState = modelingStateReducer(action: action, state: state.modelingParametrsState)
    state.peopleIlnessState = modelingIllnesStateReducer(action: action, state: state.peopleIlnessState)
    state.recalculateState = recalculateValueReducer(action: action, state: state.recalculateState)
    
    return state
}

