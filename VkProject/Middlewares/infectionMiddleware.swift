import ReSwift
import Foundation

let infectionMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            
            if let action = action as? InfectPersonAction {
                if !mainStore.state.recalculateState.activate {
                    dispatch(RecalculateStateChange(value: true))
                    dispatch(RecalculateStateActivateAction())
                }
                
                dispatch(SpreadVirusAction(index: action.index))
            }
    
            
            if let action = action as? SpreadVirusAction {
                let state = getState()
                
                let currentCellStates = state?.peopleIlnessState.people ?? []
                let currentInfectedCount = state?.peopleIlnessState.infectionCount ?? 0
                var currentIndexesIllnes = state?.peopleIlnessState.infectionPeopleIndexes ?? []
                
                if currentIndexesIllnes.count >= currentCellStates.count {
                    dispatch(UpdateValuesIllnesAction(illnesCount: currentInfectedCount, people: currentCellStates, illnesPeopleIndex: currentIndexesIllnes))
                    dispatch(RecalculateStateStopAction())
                    
                    return
                }
                
                
                var updatedCellStates = currentCellStates
                var newInfectedCount = currentInfectedCount
                var updatedIndexesIllnes = currentIndexesIllnes
                
                if !updatedCellStates[action.index].isInfected {
                    updatedCellStates[action.index].isInfected = true
                    updatedIndexesIllnes.append(action.index)
                    newInfectedCount += 1
                }
                
                dispatch(UpdateValuesIllnesAction(illnesCount: newInfectedCount, people: updatedCellStates, illnesPeopleIndex: updatedIndexesIllnes))
                
            }
            
            if let action = action as? PersonsPushToStateAction {
                let value = Source.shared.createPeopleArray(count: action.groupSize)
                var changedArr = [People]()
                
                for i in value {
                    let temp = People(isInfected: false, name: i.name, image: i.image)
                    changedArr.append(temp)
                }
                
                dispatch(PersonToPeopleAction(people: changedArr))
            }
            
            if let action = action as? RecalculateStateActivateAction {
                let time = mainStore.state.modelingParametrsState.time
                StateRecalculationTimer.shared.updateTimeInterval(to: TimeInterval(time))
            }
            
            if let action = action as? RecalculateStateStopAction {
                StateRecalculationTimer.shared.stop()
            }
            
            if let action = action as? ClearStateForModellingAction {
                dispatch(RecalculateStateChange(value: false))
                dispatch(ClearStateAction())
            }
            
            return next(action)
        }
    }
}
