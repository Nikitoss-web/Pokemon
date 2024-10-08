import Foundation

protocol SettingsVCDelegate: AnyObject {
    
    func settingsVCDidUpdateData(id_pokemon: String?, name: String?)
}

class ViewControllerModel {
    var testLoaded: (() -> Void)?
    var id_pokemon: String?
    var name: String?
    private let networkMonitor = NetworkMonitor()
    private let url: NamePokemon
    private var fetchedPokemons: [UrlPokemonStruct] = []
    
    init(url: NamePokemon) {
        self.url = url
    }
    
    var urls: [UrlPokemonStruct] = [] {
        didSet{
            testLoaded?()
        }
    }
    var urlCount: Int {
        fetchedPokemons.count
    }
    func urlID(at index: Int) -> String {
        return fetchedPokemons[index].url
    }
    
    
    func urlName(at index: Int) -> String {
        return fetchedPokemons[index].name
    }
    
    func fetchUrlPokemon(){
        if networkMonitor.isInternetAvailable() {
            url.viewResultName() { [weak self] (result: Result<[UrlPokemonStruct]?, ErrorAPI>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let pokemons):
                        if let pokemon = pokemons{
                            self?.fetchedPokemons = pokemon
                            self?.testLoaded?()
                            
                        }
                    case .failure(let error):
                        print("Ошибка при получении результатов: \(error)")
                    }
                }
            }
        } else {
            let urls = CoreDataService.shared.fetchUrl()
            self.fetchedPokemons = urls.map { UrlPokemonStruct(name: $0, url: "")}
            self.testLoaded?()
        }
    }
    
    func settingsVCDelegate(urls: String?, names: String?, vc: InformationPokemonViewModel){
        vc.id_pokemon = urls
        vc.name = names
        vc.delegate = self
    }
    
}
extension ViewControllerModel: SettingsVCDelegate{
    func settingsVCDidUpdateData(id_pokemon: String?, name: String?){
        self.id_pokemon = id_pokemon
        self.name = name
    }
}
