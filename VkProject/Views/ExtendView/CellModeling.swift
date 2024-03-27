import UIKit
import Foundation


class CellModeling: UICollectionViewCell {
    
    // MARK: - UI Elements
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .CellModelingCell.label.font
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Constraints
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(cellImageView)

        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutConstraints.constant10.rawValue),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstraints.constant10.rawValue),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstraints.constantMinus10.rawValue),
            
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstraints.constant10.rawValue),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstraints.constant10.rawValue),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstraints.constantMinus10.rawValue),
            cellImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: LayoutConstraints.constantMinus10.rawValue),
        ])
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UpdateUI
    func updateContentForZoomLevel(zoomLevel: CGFloat) {
        
        let baseFontSize: CGFloat = FontSize.baseFontSize.rawValue
        let minFontSize: CGFloat = FontSize.minFontSize.rawValue

        var currentFontSize = baseFontSize

        if zoomLevel > ZoomLevelValues.minValue.rawValue && zoomLevel <= ZoomLevelValues.maxValue.rawValue {
            currentFontSize = max(baseFontSize / zoomLevel, minFontSize)
        } else if zoomLevel < ZoomLevelValues.minValue.rawValue {
            currentFontSize = baseFontSize + (baseFontSize / zoomLevel)
        }
        
        if zoomLevel > ZoomLevelValues.maxValue.rawValue {
            nameLabel.isHidden = true
        } else {
            nameLabel.isHidden = false
        }
        
        nameLabel.font = .CellModelingCell.nameLabel(currentFontSize).font
        
    }
    
    func updateContent(with person: People, zoomLevel: CGFloat) {
        nameLabel.text = person.name
        cellImageView.image = UIImage(named: person.image)
        cellImageView.contentMode = .scaleAspectFit
        
        updateContentForZoomLevel(zoomLevel: zoomLevel)
    }
}

fileprivate enum LayoutConstraints: CGFloat {
    case constant10 = 10
    case constantMinus10 = -10
}

fileprivate enum FontSize: CGFloat {
    case baseFontSize = 11.0
    case minFontSize = 7.0
}

fileprivate enum ZoomLevelValues: CGFloat {
    case maxValue = 8.0
    case minValue = 6.0
}
