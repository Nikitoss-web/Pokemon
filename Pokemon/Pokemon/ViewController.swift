import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ViewControllerModel(url: APINamePokemon())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.fetchUrlPokemon()
        bind()
    }
    
    private func bind() {
        viewModel.testLoaded = {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.urlCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.MainCellIdentifier.rawValue , for: indexPath)
        cell.textLabel?.text = viewModel.urlName(at: indexPath.row)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: EnumScreen.informationPokemon.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: InformationPokemonView.self)) as? InformationPokemonView {
            viewModel.settingsVCDelegate(urls: viewModel.urlID(at: indexPath.row), names: viewModel.urlName(at: indexPath.row), vc: vc.viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

