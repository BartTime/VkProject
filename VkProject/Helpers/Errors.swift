import Foundation

enum ErrorWithCheckParams: Error, Equatable {
    case invalidGS
    case invalidGSNotInt
    case invalidIF
    case invalidIFNotInt
    case invalidTime
    case invalidTimeNotInt
    case invalidValueMax
    case invalidMaxValueTime
    
    var localizeDescription: String {
        switch self {
        case .invalidGS:
            return "Добавьте Group Size"
        case .invalidGSNotInt:
            return "Значение Group Size не равно целочисленному значению"
        case .invalidIF:
            return "Добавьте Infection Size"
        case .invalidIFNotInt:
            return "Значение Infection Size не равно целочисленному значению"
        case .invalidTime:
            return "Добавьте Time"
        case .invalidTimeNotInt:
            return "Значение Time не равно целочисленному значению"
        case .invalidValueMax:
            return "Значние InfectionSize не может быть больше 6"
        case .invalidMaxValueTime:
            return "Значение Time не может быть больше 15"
        }
    }
}
