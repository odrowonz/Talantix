import Foundation
struct Exif : Codable, CustomStringConvertible, CustomDebugStringConvertible {
	let tagspace : String?
	let tagspaceid : Int?
	let tag : String?
	let label : String?
	let raw : Raw?
    let clean: Raw?
    
    var description: String {
        let part1: String
        if let key1 = tagspace {
            if let key2 = label ?? tag {
                part1 = "\(key1):\(key2)"
            } else {
                part1 = "\(key1)"
            }
        } else {
            part1 = ""
        }
        
        if let part2 = clean ?? raw {
            return "\(part1)=\(part2)"
        } else {
            return "\(part1)"
        }
    }
    
    var debugDescription: String {
        return description
    }
    
	enum CodingKeys: String, CodingKey {
		case tagspace = "tagspace"
		case tagspaceid = "tagspaceid"
		case tag = "tag"
		case label = "label"
		case raw = "raw"
        case clean = "clean"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		tagspace = try values.decodeIfPresent(String.self, forKey: .tagspace)
		tagspaceid = try values.decodeIfPresent(Int.self, forKey: .tagspaceid)
		tag = try values.decodeIfPresent(String.self, forKey: .tag)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		raw = try values.decodeIfPresent(Raw.self, forKey: .raw)
        clean = try values.decodeIfPresent(Raw.self, forKey: .clean)
	}

}
