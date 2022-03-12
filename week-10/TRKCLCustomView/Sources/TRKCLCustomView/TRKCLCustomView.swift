import UIKit

public class TRKCLCheckBox: UIControl {
    private weak var checkboxImageView: UIImageView!
    
    private var checkboxImage: UIImage {
        return checked ? UIImage(named: "check")! : UIImage(named: "unchecked")!
    }
    
    open var checked: Bool = false {
        didSet {
            checkboxImageView.image = checkboxImage
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit(){
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = checkboxImage
        self.checkboxImageView = imageView
        backgroundColor = .clear
        
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }
    
    @objc private func toggle() {
        checked.toggle()
        sendActions(for: .valueChanged)
    }
}
