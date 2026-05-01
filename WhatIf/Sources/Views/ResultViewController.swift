import UIKit

class ResultViewController: UIViewController {
    let questionText: String
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let questionLabel = UILabel()
    private let reportCard = UIView()
    private let shareButton = UIButton(type: .system)

    init(question: String) {
        self.questionText = question
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        generateReport()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#1A0A2E") ?? .black
        navigationController?.navigationBar.isHidden = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        questionLabel.text = questionText
        questionLabel.font = .systemFont(ofSize: 22, weight: .bold)
        questionLabel.textColor = UIColor(hex: "#FFB347") ?? .orange
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionLabel)

        reportCard.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        reportCard.layer.cornerRadius = 20
        reportCard.layer.borderWidth = 1
        reportCard.layer.borderColor = (UIColor(hex: "#FFB347") ?? .orange).withAlphaComponent(0.2).cgColor
        reportCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reportCard)

        shareButton.setTitle("Share Result", for: .normal)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        shareButton.backgroundColor = (UIColor(hex: "#00D4FF") ?? .cyan).withAlphaComponent(0.2)
        shareButton.setTitleColor(UIColor(hex: "#00D4FF") ?? .cyan, for: .normal)
        shareButton.tintColor = UIColor(hex: "#00D4FF") ?? .cyan
        shareButton.layer.cornerRadius = 20
        shareButton.layer.borderWidth = 1
        shareButton.layer.borderColor = (UIColor(hex: "#00D4FF") ?? .cyan).withAlphaComponent(0.3).cgColor
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.addTarget(self, action: #selector(shareResult), for: .touchUpInside)
        contentView.addSubview(shareButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            reportCard.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 24),
            reportCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            reportCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            shareButton.topAnchor.constraint(equalTo: reportCard.bottomAnchor, constant: 30),
            shareButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 200),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
            shareButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }

    private func generateReport() {
        let reportData = makeReport(for: questionText)
        var previousSection: UIView? = nil
        for (index, section) in reportData.enumerated() {
            let sectionView = makeSection(title: section.title, body: section.body, accent: section.accent)
            sectionView.translatesAutoresizingMaskIntoConstraints = false
            reportCard.addSubview(sectionView)

            let isLast = (index == reportData.count - 1)

            NSLayoutConstraint.activate([
                sectionView.leadingAnchor.constraint(equalTo: reportCard.leadingAnchor, constant: 20),
                sectionView.trailingAnchor.constraint(equalTo: reportCard.trailingAnchor, constant: -20),
            ])

            if let prev = previousSection {
                sectionView.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 12).isActive = true
            } else {
                sectionView.topAnchor.constraint(equalTo: reportCard.topAnchor, constant: 20).isActive = true
            }

            if isLast {
                sectionView.bottomAnchor.constraint(equalTo: reportCard.bottomAnchor, constant: -20).isActive = true
            }

            previousSection = sectionView
        }
    }

    private func makeReport(for question: String) -> [(title: String, body: String, accent: UIColor)] {
        return [
            ("📋 Executive Summary",
             "After extensive simulation, we conclude that \(question.lowercased()) would fundamentally reshape human civilization. Our models suggest a 94.7% probability of unintended consequences.",
             UIColor(hex: "#FFB347") ?? .orange),
            ("🔬 Methodology",
             "We employed vibes-based statistics and consulted one (1) confused parrot. Sample size determined via vibes.",
             UIColor(hex: "#00D4FF") ?? .cyan),
            ("📊 Key Findings",
             "1. Fun factor: 9.8/10 (scientifically proven)\n2. Existential risk: Moderate (Class 2)\n3. TikTok potential: Extremely high",
             UIColor(hex: "#FF6B6B") ?? .red),
            ("💬 Critical Analysis",
             "Critics may argue our methodology lacks peer review. Our lead researcher stands by these findings. The data speaks for itself.",
             UIColor(hex: "#4ECDC4") ?? .green),
            ("📚 References",
             "- \"Everything You Know Is Wrong\" (Page, 1987)\n- Personal communication with a rock\n- One (1) dream",
             UIColor(hex: "#8B7FD3") ?? .purple)
        ]
    }

    private func makeSection(title: String, body: String, accent: UIColor) -> UIView {
        let container = UIView()
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        titleLabel.textColor = accent
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)

        let bodyLabel = UILabel()
        bodyLabel.text = body
        bodyLabel.font = .systemFont(ofSize: 14)
        bodyLabel.textColor = .white.withAlphaComponent(0.8)
        bodyLabel.numberOfLines = 0
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(bodyLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
        return container
    }

    @objc private func shareResult() {
        let text = "What if \(questionText)?\n\nGenerated by What If Machine 🌀"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
