import Foundation
struct ExifFormat : Codable, CustomStringConvertible, CustomDebugStringConvertible {
    
	let photo : Photo?
	let stat : String?
    
    var description: String {
        if let exifs = photo?.exif, exifs.count > 0 {
            return exifs.reduce("") {
                if $0 != "" {
                    return "\($0), \($1)"
                } else {
                    return "\($1)"
                }
            }
        } else {
            return "Exif no"
        }
    }
    
    var debugDescription: String {
        return description
    }
    
    
	enum CodingKeys: String, CodingKey {
		case photo = "photo"
		case stat = "stat"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		photo = try values.decodeIfPresent(Photo.self, forKey: .photo)
		stat = try values.decodeIfPresent(String.self, forKey: .stat)
	}
    


}
