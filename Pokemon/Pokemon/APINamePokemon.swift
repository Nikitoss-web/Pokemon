import Foundation

protocol NamePokemon {
    func viewResultName(completion: @escaping (Result<[UrlPokemonStruct]?, ErrorAPI>) -> Void)
}

final class APINamePokemon: NamePokemon  {
    
    func viewResultName( completion: @escaping (Result<[UrlPokemonStruct]?, ErrorAPI>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon")!
        var request = URLRequest(url: url)
        request.httpMethod = EnumAPI.httpMethodGet.rawValue
        request.addValue(EnumAPI.application.rawValue, forHTTPHeaderField: EnumAPI.content.rawValue)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.decodingError(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let pokemonResponse = try JSONDecoder().decode(UrlPokemonResponse.self, from: data)
                CoreDataService.shared.saveUrlPokemon(with: pokemonResponse.results)
                completion(.success(pokemonResponse.results))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}

