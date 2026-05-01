import UIKit

class HomeViewController: UIViewController {

    private let logoLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let inputField = UITextField()
    private let generateButton = UIButton(type: .system)
    private let examplesScrollView = UIScrollView()
    private let examplesStack = UIStackView()
    private let particlesView = ParticleBackgroundView()

    private let sampleQuestions = [
        "What if gravity was just a suggestion?",
        "What if dogs could use Tinder?",
        "What if the moon was made of cheese?",
        "What if water had memory?",
        "What if AI became self-aware in 2025?",
        "What if humans could photosynthesize?",
        "What if time stopped for everyone but you?",
        "What if your shadow had opinions?",
        "What if the internet had a consciousness?",
        "What if chairs could walk?"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#1A0A2E") ?? .black
        navigationController?.navigationBar.isHidden = true

        view.addSubview(particlesView)
        particlesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            particlesView.topAnchor.constraint(equalTo: view.topAnchor),
            particlesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            particlesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            particlesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        logoLabel.text = "What If Machine"
        logoLabel.font = .systemFont(ofSize: 34, weight: .heavy)
        logoLabel.textColor = UIColor(hex: "#FFB347") ?? .orange
        logoLabel.textAlignment = .center
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoLabel)

        subtitleLabel.text = "Ask anything. Get seriously absurd answers."
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .light)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)

        inputField.placeholder = "What if..."
        inputField.font = .systemFont(ofSize: 18)
        inputField.textColor = .white
        inputField.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        inputField.layer.cornerRadius = 16
        inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        inputField.leftViewMode = .always
        inputField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        inputField.rightViewMode = .always
        inputField.attributedPlaceholder = NSAttributedString(string: "What if...", attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.delegate = self
        view.addSubview(inputField)

        generateButton.setTitle("Generate →", for: .normal)
        generateButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        generateButton.backgroundColor = UIColor(hex: "#FFB347") ?? .orange
        generateButton.setTitleColor(UIColor(hex: "#1A0A2E") ?? .black, for: .normal)
        generateButton.layer.cornerRadius = 25
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        generateButton.addTarget(self, action: #selector(generateAnswer), for: .touchUpInside)
        view.addSubview(generateButton)

        examplesScrollView.showsHorizontalScrollIndicator = false
        examplesScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(examplesScrollView)

        examplesStack.axis = .horizontal
        examplesStack.spacing = 10
        examplesStack.translatesAutoresizingMaskIntoConstraints = false
        examplesScrollView.addSubview(examplesStack)

        for q in sampleQuestions {
            let chip = makeChip(text: q)
            examplesStack.addArrangedSubview(chip)
        }

        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            subtitleLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            inputField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            inputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            inputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            inputField.heightAnchor.constraint(equalToConstant: 56),

            generateButton.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 20),
            generateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generateButton.widthAnchor.constraint(equalToConstant: 200),
            generateButton.heightAnchor.constraint(equalToConstant: 50),

            examplesScrollView.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 40),
            examplesScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            examplesScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            examplesScrollView.heightAnchor.constraint(equalToConstant: 44),

            examplesStack.topAnchor.constraint(equalTo: examplesScrollView.topAnchor),
            examplesStack.bottomAnchor.constraint(equalTo: examplesScrollView.bottomAnchor),
            examplesStack.leadingAnchor.constraint(equalTo: examplesScrollView.leadingAnchor, constant: 24),
            examplesStack.trailingAnchor.constraint(equalTo: examplesScrollView.trailingAnchor, constant: -24),
            examplesStack.heightAnchor.constraint(equalTo: examplesScrollView.heightAnchor)
        ])
    }

    private func makeChip(text: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        btn.setTitleColor(UIColor(hex: "#00D4FF") ?? .cyan, for: .normal)
        btn.backgroundColor = (UIColor(hex: "#00D4FF") ?? .cyan).withAlphaComponent(0.15)
        btn.layer.cornerRadius = 16
        btn.layer.borderWidth = 1
        btn.layer.borderColor = (UIColor(hex: "#00D4FF") ?? .cyan).withAlphaComponent(0.3).cgColor
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        btn.addTarget(self, action: #selector(chipTapped(_:)), for: .touchUpInside)
        return btn
    }

    @objc private func chipTapped(_ sender: UIButton) {
        guard let text = sender.title(for: .normal) else { return }
        inputField.text = text
        generateAnswer()
    }

    @objc private func generateAnswer() {
        let question = inputField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let q = question, !q.isEmpty else { return }

        let resultVC = ResultViewController(question: q)
        navigationController?.pushViewController(resultVC, animated: true)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        generateAnswer()
        return true
    }
}

// Particle background effect
class ParticleBackgroundView: UIView {
    private var emitters: [CAEmitterLayer] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: -10)
        emitter.emitterSize = CGSize(width: bounds.width, height: 1)
        emitter.emitterShape = .line
        emitter.renderMode = .additive

        var cells: [CAEmitterCell] = []
        for i in 0..<3 {
            let cell = CAEmitterCell()
            cell.birthRate = Float(2 + i)
            cell.lifetime = 8
            cell.velocity = CGFloat(30 + i * 10)
            cell.velocityRange = 20
            cell.emissionLongitude = .pi
            cell.scale = 0.08
            cell.scaleRange = 0.04
            cell.alphaSpeed = -0.1
            cell.contents = UIImage(systemName: "sparkle")?.withTintColor(.white, renderingMode: .alwaysOriginal).cgImage
            cells.append(cell)
        }
        emitter.emitterCells = cells
        layer.addSublayer(emitter)
        emitters.append(emitter)
    }

    required init?(coder: NSCoder) { fatalError() }
    override func layoutSubviews() {
        super.layoutSubviews()
        emitters.first?.emitterPosition = CGPoint(x: bounds.midX, y: -10)
        emitters.first?.emitterSize = CGSize(width: bounds.width, height: 1)
    }
}

extension UIImage {
    var cgImage: CGImage? { self.cgImage }
}