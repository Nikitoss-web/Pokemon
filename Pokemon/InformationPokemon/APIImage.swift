import Foundation

protocol ImageResult {
    func viewResultImage(url: String, completion: @escaping (Result<Data?, ErrorAPI>) -> Void)
}

final class APIImage: ImageResult {
    
    func viewResultImage(url: String, completion: @escaping (Result<Data?, ErrorAPI>) -> Void) {
        let url = URL(string: url)!
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
            completion(.success(data))
            CoreDataService.shared.saveImagePokemon(with: data)
        }
        task.resume()
    }
}
