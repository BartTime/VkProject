import Foundation
import ReSwift

let mainMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            
            if let action = action as? StartModelingActionTapped {
                if action.tapped {
                    CheckParamsConfigView.shared.request(
                        valueGroupSize: action.valueGroupSize,
                        valueInfectionFactor: action.infetionFactor,
                        valueTime: action.time) { result in
                            
                            switch result {
                            case .success(let val):
                                dispatch(PushModellingParametes(valueGroupSize: val.1,
                                                                infectionFactor: val.2,
                                                                time: val.3))
                                
                                dispatch(PersonsPushToStateAction(groupSize: val.1))
                                
                                dispatch(StartModelingAction(
                                    tapped: val.0,
                                    error: nil
                                ))
                                
                            case .failure(let val):
                                dispatch(StartModelingAction(tapped: false, 
                                                             error: val
                                                             ))
                            }
                    }
                } else {
                    dispatch(StartModelingAction(tapped: false, 
                                                 error: nil
                                                 ))
                }
            }
            
            
            return next(action)
        }
    }
}
