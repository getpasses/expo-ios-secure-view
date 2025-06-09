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

  #if RCT_NEW_ARCH_ENABLED
    override func insertSubview(_ view: UIView, at index: Int) {
        if view !== secureContentFrame {
            self.secureMode = true
            setupView(contentView: view)
        } else {
            super.insertSubview(view, at: index)
        }
    }

    override func unmountChildComponentView(_ childComponentView: UIView, index: Int) {
        if childComponentView.superview !== self {
            childComponentView.removeFromSuperview()
            super.insertSubview(childComponentView, at: index)
        }
        super.unmountChildComponentView(childComponentView, index: index)
    }
  #else
    override func addSubview(_ view: UIView) {
        
        print("[SecureView] addSubview called with: \(type(of: view))")
        
        if view !== secureContentFrame {
            print("[SecureView] addSubview: setting up secure content")
            self.secureMode = true
            setupView(contentView: view)
        } else {
            print("[SecureView] addSubview: adding secureContentFrame directly")
            super.addSubview(view)
        }
    }
      #endif
}
