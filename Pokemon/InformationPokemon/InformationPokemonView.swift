import Foundation
import UIKit

class InformationPokemonView: UIViewController{
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var typesLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    @IBOutlet weak var heightLable: UILabel!
    let viewModel = InformationPokemonViewModel(images: APIImage(), descriptions: APIDecription())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData() {
        viewModel.checkingConectionDecription { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
                self?.viewModel.outputImage(photo: self?.photo ?? UIImageView())
            }
        }
    }
    
    private func updateUI() {
        if let result = viewModel.outputResult() {
            nameLable.text = result.name
            heightLable.text = String(result.height)
            weightLable.text = String(result.weight)
            typesLable.text = result.types
        }
    }
    
}
