import Foundation
import UIKit


class InformationPokemonViewModel{
    var id_pokemon: String?
    var name: String?
    weak var delegate: SettingsVCDelegate?
    private var decriptionAPI = APIDecription()
    private var imageAPI = APIImage()
    private var fetchedDecription: DecriptionPokemonResponse?
    private let networkMonitor = NetworkMonitor()
    private var images: ImageResult
    private var descriptions: ResultDecription
    
    init(images: ImageResult, descriptions: ResultDecription){
        self.images = images
        self.descriptions = descriptions
    }
    
    func checkingConectionDecription(completion: @escaping () -> Void){
        delegate?.settingsVCDidUpdateData(id_pokemon: id_pokemon, name: name)
        
        if networkMonitor.isInternetAvailable() {
            decriptionAPI.viewResultDecription(url: id_pokemon ){ [weak self] (result: Result<DecriptionPokemonResponse?, ErrorAPI>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let decriptions):
                        
                        self?.outputResult()
                        completion()
                    case .failure(let error):
                        print("Ошибка при получении результатов описания: \(error)")
                        completion()
                    }
                }
            }
        }
        else {
            self.outputResult()
            completion()
        }
    }
    
    func outputImage(photo: UIImageView){
        if networkMonitor.isInternetAvailable() {
            fetchImagePokemon { [weak self] imageData in
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    photo.image = image
                } else {
                    print("Не удалось загрузить изображение")
                }
            }
        }
        else {
            guard let images = CoreDataService.shared.fetchImage() else { return  }
            let image = UIImage(data: images)
            photo.image = image
        }
    }
    
    
    func outputResult() -> newDecription? {
        if let result = CoreDataService.shared.fetchDescription(byName: name ?? ""){
            let output = newDecription(
                height: result.height,
                id:  Int(result.id),
                name: result.name ?? "",
                weight: result.weight,
                types: result.types
            )
            return output
        }
        return nil
    }
    
    private func fetchImagePokemon(completion: @escaping (Data?) -> Void) {
        imageAPI.viewResultImage(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/3.png") { [weak self] (result: Result<Data?, ErrorAPI>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    completion(imageData)
                    print("Изображение успешно загружено")
                    
                case .failure(let error):
                    print("Ошибка при получении результатов: \(error)")
                    completion(nil)
                }
            }
        }
    }
}
