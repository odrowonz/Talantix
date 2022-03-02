import Foundation
struct Photo : Codable {
	let id : String?
	let owner : String?
	let secret : String?
	let server : String?
	let farm : Int?
	let title : String?
	let isPublic : Int?
	let isFriend : Int?
	let isFamily : Int?
	let urlQ : String?
	let heightQ : Int?
	let widthQ : Int?
    let urlC : String?
    let heightC : Int?
    let widthC : Int?
    let camera : String?
    let exif : [Exif]?
    
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case owner = "owner"
		case secret = "secret"
		case server = "server"
		case farm = "farm"
		case title = "title"
		case isPublic = "ispublic"
		case isFriend = "isfriend"
		case isFamily = "isfamily"
		case urlQ = "url_q"
		case heightQ = "height_q"
		case widthQ = "width_q"
        case urlC = "url_c"
        case heightC = "height_c"
        case widthC = "width_c"
        case camera = "camera"
        case exif = "exif"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		owner = try values.decodeIfPresent(String.self, forKey: .owner)
		secret = try values.decodeIfPresent(String.self, forKey: .secret)
		server = try values.decodeIfPresent(String.self, forKey: .server)
		farm = try values.decodeIfPresent(Int.self, forKey: .farm)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		isPublic = try values.decodeIfPresent(Int.self, forKey: .isPublic)
		isFriend = try values.decodeIfPresent(Int.self, forKey: .isFriend)
		isFamily = try values.decodeIfPresent(Int.self, forKey: .isFamily)
		urlQ = try values.decodeIfPresent(String.self, forKey: .urlQ)
		heightQ = try values.decodeIfPresent(Int.self, forKey: .heightQ)
		widthQ = try values.decodeIfPresent(Int.self, forKey: .widthQ)
        urlC = try values.decodeIfPresent(String.self, forKey: .urlC)
        heightC = try values.decodeIfPresent(Int.self, forKey: .heightC)
        widthC = try values.decodeIfPresent(Int.self, forKey: .widthC)
        camera = try values.decodeIfPresent(String.self, forKey: .camera)
        exif = try values.decodeIfPresent([Exif].self, forKey: .exif)
    }

}
