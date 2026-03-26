//
//  CreatureDetail.swift
//  CatchEmAll
//
//  Created by Wang Sige on 3/17/26.
//

import Foundation

@Observable
class CreatureDetail{
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite
    }
    
    struct Sprite: Codable{
        var front_default: String?
        var other: Other
    }
    
    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable{
        var front_default: String?
    }
    
    var urlString = ""
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    
    func getData() async{
        print("🕸️ We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else{
                print("😡 JSON ERROR: Could not decode")
                return
            }
            self.height = returned.height
            self.weight = returned.weight
            self.imageURL = returned.sprites.other.officialArtwork.front_default ?? "n/a"
        }catch{
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
}





