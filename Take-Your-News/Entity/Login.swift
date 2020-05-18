import Foundation

struct Login: Encodable {
    let login: String
    let password: String
    
    func getBasicAuth() -> String? {
        
        let loginString = "\(self.login):\(self.password)"
        guard let loginData = loginString.data(using: .utf8) else { return nil}
        let base64data = loginData.base64EncodedString()
        
        return base64data
    }
}
