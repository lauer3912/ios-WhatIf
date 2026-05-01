import UIKit

class SettingsViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let settingsItems = [
        ("star.fill", "Rate App", "Leave a review"),
        ("square.and.arrow.up", "Share", "Tell a friend"),
        ("questionmark.circle", "About", "Version 1.0.0"),
        ("trash", "Clear History", "Delete all what-ifs")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#1A0A2E") ?? .black
        title = "Settings"
        navigationController?.navigationBar.isHidden = false

        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = settingsItems[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.image = UIImage(systemName: item.0)
        config.imageProperties.tintColor = UIColor(hex: "#FFB347") ?? .orange
        config.text = item.1
        config.secondaryText = item.2
        config.textProperties.color = .white
        config.secondaryTextProperties.color = .white.withAlphaComponent(0.5)
        cell.contentConfiguration = config
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}