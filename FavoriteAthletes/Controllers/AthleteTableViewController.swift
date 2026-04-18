import UIKit

class AthleteTableViewController: UITableViewController {

    var athletes: [Athlete] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Athletes"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addAthlete))
        navigationItem.rightBarButtonItem?.tintColor = .systemOrange
        navigationItem.leftBarButtonItem?.tintColor = .systemOrange
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AthleteCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 76, bottom: 0, right: 0)
        
        // Empty state
        let emptyLabel = UILabel()
        emptyLabel.text = "Tap + to add your\nfavorite athletes"
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .secondaryLabel
        emptyLabel.font = .systemFont(ofSize: 18, weight: .medium)
        emptyLabel.numberOfLines = 0
        tableView.backgroundView = emptyLabel
    }

    @objc func addAthlete() {
        let detail = AthleteDetailTableViewController(style: .insetGrouped)
        detail.delegate = self
        navigationController?.pushViewController(detail, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView?.isHidden = !athletes.isEmpty
        return athletes.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AthleteCell", for: indexPath)
        let athlete = athletes[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        // Name
        content.text = athlete.name
        content.textProperties.font = .systemFont(ofSize: 17, weight: .semibold)
        
        // Subtitle
        var parts: [String] = []
        if !athlete.team.isEmpty { parts.append(athlete.team) }
        if !athlete.league.isEmpty { parts.append(athlete.league) }
        if !athlete.age.isEmpty { parts.append("Age: \(athlete.age)") }
        content.secondaryText = parts.joined(separator: " · ")
        content.secondaryTextProperties.color = .secondaryLabel
        content.secondaryTextProperties.font = .systemFont(ofSize: 14)
        
        // Avatar circle with initials
        let initials = athlete.name.components(separatedBy: " ")
            .prefix(2)
            .compactMap { $0.first.map(String.init) }
            .joined()
        let colors: [UIColor] = [.systemOrange, .systemBlue, .systemGreen, .systemPurple, .systemPink, .systemTeal]
        let color = colors[indexPath.row % colors.count]
        content.image = makeCircleImage(initials: initials, color: color)
        content.imageProperties.maximumSize = CGSize(width: 48, height: 48)
        content.imageProperties.cornerRadius = 24
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = AthleteDetailTableViewController(style: .insetGrouped)
        detail.delegate = self
        detail.athlete = athletes[indexPath.row]
        detail.editingIndex = indexPath.row
        navigationController?.pushViewController(detail, animated: true)
    }

    override func tableView(_ tableView: UITableView,
                             commit editingStyle: UITableViewCell.EditingStyle,
                             forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            athletes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Helper

    private func makeCircleImage(initials: String, color: UIColor) -> UIImage {
        let size = CGSize(width: 48, height: 48)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            color.setFill()
            UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).fill()
            
            let attrs: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 18, weight: .bold)
            ]
            let str = NSString(string: initials)
            let textSize = str.size(withAttributes: attrs)
            let point = CGPoint(x: (size.width - textSize.width) / 2,
                                y: (size.height - textSize.height) / 2)
            str.draw(at: point, withAttributes: attrs)
        }
    }
}

// MARK: - AthleteDetailDelegate

extension AthleteTableViewController: AthleteDetailDelegate {
    func didSaveAthlete(_ athlete: Athlete, at index: Int?) {
        if let index = index {
            athletes[index] = athlete
        } else {
            athletes.append(athlete)
        }
        tableView.reloadData()
    }
}
