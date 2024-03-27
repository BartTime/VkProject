import ReSwift

let mainStore = Store<AppState> (
    reducer: rootReducer,
    state: nil,
    middleware: [mainMiddleware, infectionMiddleware]
)
