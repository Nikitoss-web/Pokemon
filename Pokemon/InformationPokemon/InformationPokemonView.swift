import Foundation
import UIKit

class InformationPokemonView: UIViewController{
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var typesLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    @IBOutlet weak var heightLable: UILabel!
    let viewModel = InformationPokemonViewModel()
    private var c = APIDecription()
    private var a = APIImage()
    var fetchedDecription: DecriptionPokemonResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateData()
        viewModel.fetchDecriptionPokemon()
        result()
        
        
        a.viewResultImage(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png") { [weak self] (result: Result<Data?, ErrorAPI>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    if let imageData = imageData {
                        let image = UIImage(data: imageData)
                        self?.photo.image = image
                        print("Изображение успешно загружено")
                    } else {
                        print("Изображение не найдено")
                    }
                  
                case .failure(let error):
                    print("Ошибка при получении результатов: \(error)")
                }
            }
        }

    
        
        
        
        }
    func result(){
        nameLable.text = viewModel.outputResult()?.name
        heightLable.text = String(viewModel.outputResult()?.height ?? 0)
        weightLable.text = String(viewModel.outputResult()?.weight ?? 0)
        typesLable.text = viewModel.outputResult()?.types
        

    }
    }


