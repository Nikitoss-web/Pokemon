import Foundation

class ViewControllerModel {
    var testLoaded: (() -> Void)?
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
}
