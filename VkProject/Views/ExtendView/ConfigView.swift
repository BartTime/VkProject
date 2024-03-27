import UIKit

class ConfigView: UIView {
    // MARK: - Properties
    var actionButtonTapped: ((_ valueGroupSize: String, _ infetionFactor: String, _ time: String) -> Void)?
    
    // MARK: - UI Elements
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .configViewButtonBackground
        button.setTitle(ConfigViewConstatnsName.ButtonTitle.rawValue, for: .normal)
        button.titleLabel?.font = .ConfigureView.button.font
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = CornerRadius.ButtonCornerRadius.rawValue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: ShadowOffset.shadowOffsetWidht.rawValue, height: ShadowOffset.shadowOffsetHeight.rawValue)
        button.layer.shadowRadius = ShadowRadius.shadowRadiusButton.rawValue
        button.layer.shadowOpacity = ShadowOpacity.shadowOpacityButton.rawValue
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = .ConfigureView.firstLabel.font
        label.textColor = .black
        label.text = ConfigViewConstatnsName.TitleLabel.rawValue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var groupSizeLabel: UILabel = {
        let label = UILabel()
        label.font = .ConfigureView.descriptionLabel.font
        label.textColor = .black
        label.text = "Количество людей в моделируемой группе (Например 100). Значение не может быть пустым."
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var infectionFactorLabel: UILabel = {
        let label = UILabel()
        label.font = .ConfigureView.descriptionLabel.font
        label.textColor = .black
        label.text = "Количество людей, которое может быть заражено при контакте. Максимальное количество - 6."
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .ConfigureView.descriptionLabel.font
        label.textColor = .black
        label.text = "Период пересчета количества зараженных людей, от 1 до 15 секунд."
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var groupSizeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .textField
        textField.layer.cornerRadius = CornerRadius.TextField.rawValue
        textField.placeholder = ConfigViewConstatnsName.GroupSize.rawValue
        textField.font = .ConfigureView.textField.font
        textField.textColor = .black
        textField.textAlignment = .center
        button.layer.shadowOffset =  CGSize(width: ShadowOffset.shadowOffsetWidht.rawValue, height: ShadowOffset.shadowOffsetHeight.rawValue)
        textField.layer.shadowRadius = ShadowRadius.shadowRadiusTextField.rawValue
        textField.layer.shadowOpacity = ShadowOpacity.shadowOpacityTextField.rawValue
        return textField
    }()
    
    private lazy var infectionFactorTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .textField
        textField.layer.cornerRadius = CornerRadius.TextField.rawValue
        textField.placeholder = ConfigViewConstatnsName.InfectionFactor.rawValue
        textField.font = .ConfigureView.textField.font
        textField.textColor = .black
        textField.textAlignment = .center
        button.layer.shadowOffset =  CGSize(width: ShadowOffset.shadowOffsetWidht.rawValue, height: ShadowOffset.shadowOffsetHeight.rawValue)
        textField.layer.shadowRadius = ShadowRadius.shadowRadiusTextField.rawValue
        textField.layer.shadowOpacity = ShadowOpacity.shadowOpacityTextField.rawValue
        return textField
    }()
    
    private lazy var timeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .textField
        textField.layer.cornerRadius = CornerRadius.TextField.rawValue
        textField.placeholder = ConfigViewConstatnsName.Time.rawValue
        textField.font = .ConfigureView.textField.font
        textField.textColor = .black
        textField.textAlignment = .center
        button.layer.shadowOffset =  CGSize(width: ShadowOffset.shadowOffsetWidht.rawValue, height: ShadowOffset.shadowOffsetHeight.rawValue)
        textField.layer.shadowRadius = ShadowRadius.shadowRadiusTextField.rawValue
        textField.layer.shadowOpacity = ShadowOpacity.shadowOpacityTextField.rawValue
        return textField
    }()
    
    // MARK: - Constraints
    private func setupConstraints() {
        
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLabel.bottomAnchor.constraint(equalTo: groupSizeLabel.topAnchor, constant: LayoutConstraints.constantMinus40.rawValue),
            firstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstraints.constant20.rawValue),
            firstLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstraints.constantMinus20.rawValue)
        ])
        
        groupSizeLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                groupSizeLabel.bottomAnchor.constraint(equalTo: groupSizeTextField.topAnchor, constant: LayoutConstraints.constantMinus10.rawValue),
            groupSizeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstraints.constant20.rawValue),
            groupSizeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstraints.constantMinus20.rawValue)
        ])
        
        groupSizeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupSizeTextField.bottomAnchor.constraint(equalTo: infectionFactorLabel.topAnchor, constant: LayoutConstraints.constantMinus20.rawValue),
            groupSizeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstraints.constant20.rawValue),
            groupSizeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstraints.constantMinus20.rawValue),
            groupSizeTextField.heightAnchor.constraint(equalToConstant: LayoutConstraints.constant40.rawValue)
        ])
        
        infectionFactorLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                infectionFactorLabel.bottomAnchor.constraint(equalTo: infectionFactorTextField.topAnchor, constant: LayoutConstraints.constantMinus10.rawValue),
            infectionFactorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstraints.constant20.rawValue),
            infectionFactorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstraints.constantMinus20.rawValue)
        ])
        
        infectionFactorTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infectionFactorTextField.topAnchor.constraint(equalTo: centerYAnchor),
            infectionFactorTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstraints.constant20.rawValue),
            infectionFactorTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstraints.constantMinus20.rawValue),
            infectionFactorTextField.heightAnchor.constraint(equalToConstant: LayoutConstraints.constant40.rawValue)
        ])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: infectionFactorTextField.bottomAnchor, constant: LayoutConstraints.constant20.rawValue),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstraints.constant20.rawValue),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstraints.constantMinus20.rawValue)
        ])
        
        timeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: LayoutConstraints.constant10.rawValue),
            timeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstraints.constant20.rawValue),
            timeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstraints.constantMinus20.rawValue),
            timeTextField.heightAnchor.constraint(equalToConstant: LayoutConstraints.constant40.rawValue)
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: LayoutConstraints.constant40.rawValue),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstraints.constant70.rawValue),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutConstraints.constantMinus70.rawValue),
            button.heightAnchor.constraint(equalToConstant:  LayoutConstraints.constant50.rawValue)
        ])
    }
    
    // MARK: - Action
    @objc private func actionButton() {
        let valueGS = groupSizeTextField.text ?? ""
        let valueInfectionFactor = infectionFactorTextField.text ?? ""
        let valueTime = timeTextField.text ?? ""
        actionButtonTapped?(valueGS, valueInfectionFactor, valueTime)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        addSubview(groupSizeLabel)
        addSubview(groupSizeTextField)
        addSubview(infectionFactorLabel)
        addSubview(infectionFactorTextField)
        addSubview(timeLabel)
        addSubview(timeTextField)
        addSubview(firstLabel)
        addSubview(button)
    }
    
    // MARK: - Present Error
    func presentAllert(message: String) -> UIAlertController{
        let alert: UIAlertController = {
            let alert = UIAlertController(title: "Упс... Вы что-то упустили", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Хорошо", style: .default)
            alert.addAction(alertAction)
            return alert
        }()
        
        return alert
    }
}


// MARK: - Private enums
fileprivate enum ConfigViewConstatnsName: String {
    case TitleLabel = "Параметры моделирования"
    case GroupSize = "Group Size"
    case InfectionFactor = "Infection Factor"
    case Time = "Time"
    case ButtonTitle = "Запустить моделирование"
}

fileprivate enum CornerRadius: CGFloat {
    case ButtonCornerRadius = 25
    case TextField = 20
}

fileprivate enum LayoutConstraints: CGFloat {
    case constant40 = 40
    case constantMinus40 = -40
    case constant20 = 20
    case constantMinus20 = -20
    case constant10 = 10
    case constantMinus10 = -10
    case constant50 = 50
    case constant70 = 70
    case constantMinus70 = -70
}

fileprivate enum ShadowRadius: CGFloat {
    case shadowRadiusTextField = 3
    case shadowRadiusButton = 5
}

fileprivate enum ShadowOpacity: Float {
    case shadowOpacityTextField = 0.3
    case shadowOpacityButton = 0.7
}

fileprivate enum ShadowOffset: Int {
    case shadowOffsetWidht = 2
    case shadowOffsetHeight = 3
}
