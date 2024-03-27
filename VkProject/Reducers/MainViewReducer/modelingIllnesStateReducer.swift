import ReSwift

func modelingIllnesStateReducer(action: Action, state: PeopleIlnessState?) -> PeopleIlnessState {
    var state = state ?? PeopleIlnessState()
    
    switch action {
    case let infectAction as InfectPersonAction:
        state.people[infectAction.index].isInfected = true
        state.people[infectAction.index].image = "illPerson"
    case let pushAction as PersonToPeopleAction:
        state.people = pushAction.people
    case let updateValues as UpdateValuesIllnesAction:
        state.people = updateValues.people
        state.infectionCount = updateValues.illnesCount
        state.infectionPeopleIndexes = updateValues.illnesPeopleIndex 
    case _ as ClearStateAction:
        state.people = []
        state.infectionCount = 0
        state.infectionPeopleIndexes = []
    default:
        break
    }
    
    return state
}
