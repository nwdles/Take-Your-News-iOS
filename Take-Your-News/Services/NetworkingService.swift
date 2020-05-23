import Foundation

class NetworkingService {
    
    let baseUrl = "http://192.168.1.40/api"
    
    static let shared = NetworkingService()
    
    func createRequest<T: Decodable>(endpoint: String,
                 basicAuth: String?,
                 method: String,
                 completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let base64data = basicAuth as String? else {
            completion(.failure(NetworkingError.badEncoding))
            return
            
        }
        
        request.setValue("Basic \(base64data)", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
                
                print(unwrappedResponse.statusCode)
                
                switch unwrappedResponse.statusCode {
                case 200 ..< 300:
                    print("Success")
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data {
                        //let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        //print(json)
                        
                        if let object = try? JSONDecoder().decode(T.self, from: unwrappedData) {
                            completion(.success(object))
                        }
                }
            }
        }
        
        task.resume()
        
    }
    
}

enum NetworkingError: Error {
    case badUrl
    case badResponse
    case badEncoding
}
