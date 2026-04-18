import UIKit

protocol AthleteDetailDelegate: AnyObject {
    func didSaveAthlete(_ athlete: Athlete, at index: Int?)
}

class AthleteDetailTableViewController: UITableViewController {

    weak var delegate: AthleteDetailDelegate?
    var athlete: Athlete?
    var editingIndex: Int?

    private let fields = ["Name", "Age", "League", "Team"]
    private let icons  = ["person.fill", "calendar", "trophy.fill", "shield.fill"]
    private var textFields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = athlete == nil ? "Add Athlete" : "Edit Athlete"
        
        navigationItem.largeTitleDisplayMode = .never
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
        saveBtn.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = saveBtn
        
        tableView.keyboardDismissMode = .interactive
    }

    @objc func saveTapped() {
        guard textFields.count == 4,
              let name = textFields[0].text, !name.isEmpty else {
            // Shake animation on first field
            if let tf = textFields.first {
                let anim = CAKeyframeAnimation(keyPath: "transform.translation.x")
                anim.timingFunction = CAMediaTimingFunction(name: .linear)
                anim.duration = 0.4
                anim.values = [-8, 8, -6, 6, -4, 4, 0]
                tf.layer.add(anim, forKey: "shake")
                tf.placeholder = "Name is required!"
                tf.attributedPlaceholder = NSAttributedString(
                    string: "Name is required!",
                    attributes: [.foregroundColor: UIColor.systemRed]
                )
            }
            return
        }
        let saved = Athlete(name: name,
                            age: textFields[1].text ?? "",
                            league: textFields[2].text ?? "",
                            team: textFields[3].text ?? "")
        delegate?.didSaveAthlete(saved, at: editingIndex)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fields.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Athlete Info"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        
        // Icon
        let icon = UIImageView(image: UIImage(systemName: icons[indexPath.row]))
        icon.tintColor = .systemOrange
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(icon)
        
        // Text field
        let tf = UITextField()
        tf.placeholder = fields[indexPath.row]
        tf.font = .systemFont(ofSize: 16)
        tf.autocorrectionType = .no
        tf.returnKeyType = indexPath.row < 3 ? .next : .done
        tf.tag = indexPath.row
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        if indexPath.row == 1 { tf.keyboardType = .numberPad }
        
        if let athlete = athlete {
            switch indexPath.row {
            case 0: tf.text = athlete.name
            case 1: tf.text = athlete.age
            case 2: tf.text = athlete.league
            case 3: tf.text = athlete.team
            default: break
            }
        }
        
        cell.contentView.addSubview(tf)
        
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),
            tf.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
            tf.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            tf.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            tf.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            tf.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
        ])
        
        if textFields.count <= indexPath.row {
            textFields.append(tf)
        } else {
            textFields[indexPath.row] = tf
        }
        
        // Auto-focus name field
        if indexPath.row == 0 && athlete == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { tf.becomeFirstResponder() }
        }
        
        return cell
    }
}

// MARK: - UITextFieldDelegate

extension AthleteDetailTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let next = textField.tag + 1
        if next < textFields.count {
            textFields[next].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            saveTapped()
        }
        return true
    }
}
