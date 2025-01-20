import ExpoModulesCore

final class ExpoIosSecureView: ExpoView {
    
    public var secureMode = true {
        didSet {
            textField.isSecureTextEntry = secureMode
        }
    }
    
    private var contentView: UIView?
    private let textField = UITextField()
    
    private let detector = SecureViewDetector()
    private lazy var secureContentFrame: UIView? = try? detector.getSecureFrame(from: textField)
    
    required init(appContext: AppContext? = nil) {
        super.init(appContext: appContext)
        setupUI()
    }
    
    private func setupUI() {
        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = false
        
        guard let secureContentFrame else { return }
        
        addSubview(secureContentFrame)
        secureContentFrame.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secureContentFrame.leadingAnchor.constraint(equalTo: leadingAnchor),
            secureContentFrame.trailingAnchor.constraint(equalTo: trailingAnchor),
            secureContentFrame.topAnchor.constraint(equalTo: topAnchor),
            secureContentFrame.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        
    }
    
    public func setupView(contentView: UIView) {
        self.contentView?.removeFromSuperview()
        self.contentView = contentView
        
        guard let secureContentFrame else { return }
        
        secureContentFrame.addSubview(contentView)
        secureContentFrame.isUserInteractionEnabled = isUserInteractionEnabled
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: secureContentFrame.bottomAnchor)
        bottomConstraint.priority = .required - 1
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: secureContentFrame.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: secureContentFrame.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: secureContentFrame.topAnchor),
            bottomConstraint
        ])
    }
    
    override func addSubview(_ view: UIView) {
        if view !== secureContentFrame {
            setupView(contentView: view)
        } else {
            super.addSubview(view)
        }
    }
}
