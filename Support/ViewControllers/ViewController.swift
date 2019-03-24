import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var data: [PetVetCellViewModel]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "generic")
        cell.textLabel?.text = data?[indexPath.row].petName
        cell.detailTextLabel?.text = data?[indexPath.row].vetNameAndTitle
        return cell
    }
}
