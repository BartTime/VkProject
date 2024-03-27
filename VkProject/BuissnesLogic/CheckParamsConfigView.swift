import Foundation

struct CheckParamsConfigView {
    
    static let shared = CheckParamsConfigView()
    
    func request(
        valueGroupSize: String,
        valueInfectionFactor: String,
        valueTime: String,
        completion: @escaping(Result<(Bool, Int, Int, Int), ErrorWithCheckParams>) -> Void
    ) {
        guard valueGroupSize != "" else { completion(.failure(.invalidGS)); return }
        guard let vgs = Int(valueGroupSize) else { completion(.failure(.invalidGSNotInt)); return }
        guard vgs != Constansts.zero.rawValue else { completion(.failure(.invalidGS)); return }
        
        guard valueInfectionFactor != "" else { completion(.failure(.invalidIF)); return }
        guard let vif = Int(valueInfectionFactor) else { completion(.failure(.invalidIFNotInt)); return }
        guard vif != Constansts.zero.rawValue else { completion(.failure(.invalidIF)); return }
        guard vif < Constansts.maxValue.rawValue else { completion(.failure(.invalidValueMax)); return }
        
        guard valueTime != "" else { completion(.failure(.invalidTime)); return }
        guard let vt = Int(valueTime) else { completion(.failure(.invalidTimeNotInt)); return }
        guard vt != Constansts.zero.rawValue else { completion(.failure(.invalidTime)); return }
        guard vt < Constansts.maxValueTime.rawValue else { completion(.failure(.invalidMaxValueTime)); return }
        
        completion(.success((true, vgs, vif, vt)))
    }
}

fileprivate enum Constansts: Int {
    case zero = 0
    case maxValue = 7
    case maxValueTime = 15
}
