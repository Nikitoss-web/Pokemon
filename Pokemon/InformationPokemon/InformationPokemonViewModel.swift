import Foundation


class InformationPokemonViewModel{
    var id_pokemon: String?
    var name: String?
    weak var delegate: SettingsVCDelegate?
    private var decriptionAPI = APIDecription()
    private var imageAPI = APIImage()
    private var fetchedDecription: DecriptionPokemonResponse?
    
    func updateData() {
        
    }
    func fetchDecriptionPokemon(){
        delegate?.settingsVCDidUpdateData(id_pokemon: id_pokemon, name: name)
        decriptionAPI.viewResultDecription(url: id_pokemon ){ [weak self] (result: Result<DecriptionPokemonResponse?, ErrorAPI>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let decriptions):
                    self?.outputResult()
                case .failure(let error):
                    print("Ошибка при получении результатов описания: \(error)")
                }
            }
        }
        
    }
    
    func outputResult() -> newStruct? {
        if let result = CoreDataService.shared.fetchDescription(byName: name ?? ""){
            let output = newStruct(
                height: result.height,
                id: Int(bitPattern: result.id),
                name: result.name ?? "",
                weight: result.weight,
                types: result.types
            )
            return output
        }
        return nil
    }
}
