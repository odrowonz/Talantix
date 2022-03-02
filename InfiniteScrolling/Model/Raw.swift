import Foundation
struct Raw : Codable, CustomStringConvertible, CustomDebugStringConvertible {
	let content : String?
    
    var description: String {
        return content ?? ""
    }
    
    var debugDescription: String {
        return description
    }
    
	enum CodingKeys: String, CodingKey {
		case content = "_content"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		content = try values.decodeIfPresent(String.self, forKey: .content)
	}
}
