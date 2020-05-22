import Foundation

class NetworkingService {
    
    let baseUrl = "http://192.168.1.40/api"
    
    static let shared = NetworkingService()
    
    func handleResponse(for request: URLRequest,
                        completion: @escaping (Result<User, Error>) -> Void) {
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
                    //UserDefaults save base
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        print(json)
                        
                        if let user = try? JSONDecoder().decode(User.self, from: unwrappedData) {
                            completion(.success(user))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func request(endpoint: String,
                 loginObject: Login,
                 completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        
       /* do {
            let loginData = try JSONEncoder().encode(loginObject)
            request.httpBody = loginData
        } catch {
            completion(.failure(NetworkingError.badEncoding))
        }*/
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let base64data = loginObject.getBasicAuth() as String? else {
            completion(.failure(NetworkingError.badEncoding))
            return
            
        }
        
        request.setValue("Basic \(base64data)", forHTTPHeaderField: "Authorization")
        handleResponse(for: request, completion: completion)
        
    }
    
    func requestPublication(endpoint: String,
                 basicAuth: String?,
                 completion: @escaping (Result<PublicationList, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let base64data = basicAuth as String? else {
            completion(.failure(NetworkingError.badEncoding))
            return
            
        }
        
        request.setValue("Basic \(base64data)", forHTTPHeaderField: "Authorization")
        handleResponsePublicaion(for: request, completion: completion)
        
    }
    
    func handleResponsePublicaion(for request: URLRequest,
                        completion: @escaping (Result<PublicationList, Error>) -> Void) {
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
                    //UserDefaults save base
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data {
                    do {
                        //let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        //print(json)
                        
                        if let categories = try? JSONDecoder().decode(PublicationList.self, from: unwrappedData) {
                            completion(.success(categories))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }

    
    func requestCategory(endpoint: String,
                 basicAuth: String?,
                 completion: @escaping (Result<CategoryList, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let base64data = basicAuth as String? else {
            completion(.failure(NetworkingError.badEncoding))
            return
            
        }
        
        request.setValue("Basic \(base64data)", forHTTPHeaderField: "Authorization")
        handleResponseCategory(for: request, completion: completion)
        
    }
    
    func handleResponseCategory(for request: URLRequest,
                        completion: @escaping (Result<CategoryList, Error>) -> Void) {
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
                    //UserDefaults save base
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data {
                    do {
                        //let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        //print(json)
                        
                        if let categories = try? JSONDecoder().decode(CategoryList.self, from: unwrappedData) {
                            completion(.success(categories))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func requestFavorites(endpoint: String,
                 basicAuth: String?,
                 completion: @escaping (Result<FavoritesList, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let base64data = basicAuth as String? else {
            completion(.failure(NetworkingError.badEncoding))
            return
            
        }
        
        request.setValue("Basic \(base64data)", forHTTPHeaderField: "Authorization")
        handleResponseFavorites(for: request, completion: completion)
        
    }
    
    func handleResponseFavorites(for request: URLRequest,
                        completion: @escaping (Result<FavoritesList, Error>) -> Void) {
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
                    //UserDefaults save base
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data {
                    do {
                       // let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                       // print(json)
                        
                        if let favorites = try? JSONDecoder().decode(FavoritesList.self, from: unwrappedData) {
                            completion(.success(favorites))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))
                        }
                    } catch {
                        completion(.failure(error))
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
