struct Cases: Codable {
    
    let country : String
    let infected : Int
    let recovered : Int?
    
    private enum CodingKeys: String, CodingKey {
                case infected, recovered, country
            }

    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            infected = try container.decode(Int.self, forKey: .infected)
            country = try container.decode(String.self, forKey: .country)
            recovered = try? container.decode(Int.self, forKey: .recovered)
        }
}

