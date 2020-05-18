import Foundation

struct Publication: Decodable {
    let id: Int
    let header: String
    let description: String
    let text: String
    let image: String?
}

struct PublicationList: Decodable{
    var data: [Publication]?
}
