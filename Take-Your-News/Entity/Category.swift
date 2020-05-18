import Foundation

struct Category: Decodable {
    let id: Int
    let name: String
    let image: String?
}

struct CategoryList: Decodable{
    var data: [Category]?
}
