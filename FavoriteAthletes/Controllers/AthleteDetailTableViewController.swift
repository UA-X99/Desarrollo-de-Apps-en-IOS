import UIKit

protocol AthleteDetailDelegate: AnyObject {
    func didSaveAthlete(_ athlete: Athlete, at index: Int?)
}

class AthleteDetailTableViewController: UITableViewController {

    weak var delegate: AthleteDetailDelegate?
    var athlete: Athlete?
    var editingIndex: Int?

    private let fields = ["Name", "Age", "League", "Team"]
    private var textFields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = athlete == nil ? "Add Athlete" : "Edit Athlete"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveTapped))
    }

    @objc func saveTapped() {
        guard textFields.count == 4,
              let name = textFields[0].text, !name.isEmpty else {
            let alert = UIAlertController(title: "Error",
                                          message: "Name is required.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        let saved = Athlete(name: name,
                            age: textFields[1].text ?? "",
                            league: textFields[2].text ?? "",
                            team: textFields[3].text ?? "")
        delegate?.didSaveAthlete(saved, at: editingIndex)
        navigationController?.popViewController(animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fields.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        let tf = UITextField(frame: CGRect(x: 16, y: 0, width: cell.contentView.bounds.width - 32, height: 44))
        tf.autoresizingMask = [.flexibleWidth]
        tf.placeholder = fields[indexPath.row]
        tf.autocorrectionType = .no
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
        if textFields.count <= indexPath.row {
            textFields.append(tf)
        } else {
            textFields[indexPath.row] = tf
        }
        return cell
    }
}
