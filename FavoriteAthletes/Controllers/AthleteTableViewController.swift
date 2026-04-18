import UIKit

class AthleteTableViewController: UITableViewController {

    var athletes: [Athlete] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Athletes"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addAthlete))
    }

    @objc func addAthlete() {
        let detail = AthleteDetailTableViewController(style: .grouped)
        detail.delegate = self
        navigationController?.pushViewController(detail, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        athletes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AthleteCell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "AthleteCell")
        let athlete = athletes[indexPath.row]
        cell.textLabel?.text = athlete.name
        cell.detailTextLabel?.text = "\(athlete.team) - \(athlete.league)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = AthleteDetailTableViewController(style: .grouped)
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
}

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
