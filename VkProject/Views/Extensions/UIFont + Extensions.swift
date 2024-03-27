import UIKit

extension UIFont {
    enum ConfigureView {
        case button
        case firstLabel
        case textField
        case descriptionLabel
        
        var font: UIFont! {
            switch self {
            case .button:
                return UIFont(name: "HelveticaNeue-Bold", size: 15)
            case .firstLabel:
                return UIFont(name: "HelveticaNeue-Bold", size: 24)
            case .textField:
                return UIFont(name: "HelveticaNeue-Regular", size: 18)
            case .descriptionLabel:
                return UIFont.systemFont(ofSize: 14)
            }
            
        }
    }
    
    enum ModelingView {
        case label
        
        var font: UIFont! {
            switch self {
            case .label:
                return UIFont(name: "Arial", size: 22)
            }
        }
    }
    
    enum CellModelingCell {
        case label
        case nameLabel(CGFloat)
        
        var font: UIFont! {
            switch self {
            case .label:
                return UIFont(name: "Arial", size: 11)
            case .nameLabel(let value):
                return UIFont(name: "Arial", size: value)
            }
        }
    }
    

}
