//
//  Transport.swift
//  Departures
//
//  Created by Namasang Yonzan on 10/06/21.
//

import Foundation
import JSONParsing

public final class Transport: JSONParseable {
    var typeId: Int
    var departureTime: String
    var name: String
    var latitude: Double
    var longitude: Double
    var isExpress: Bool
    var hasMyKiTopUp: Bool
    
    init(typeId: Int,
         departureTime: String,
         name: String,
         latitude: Double,
         longitude: Double,
         isExpress: Bool,
         hasMyKiTopUp: Bool) {
        self.typeId = typeId
        self.departureTime = departureTime
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.isExpress = isExpress
        self.hasMyKiTopUp = hasMyKiTopUp
    }
    
    public static func parse(_ json: JSON) throws -> Transport {
        return try Transport(typeId: json["typeId"]^,
                             departureTime: json["departureTime"]^,
                             name: json["name"]^,
                             latitude: json["latitude"]^,
                             longitude: json["longitude"]^,
                             isExpress: (json["isExpress"]^? ?? false ),
                             hasMyKiTopUp: json["hasMyKiTopUp"]^? ??  false)
    }
}

extension Transport {
    //Fetching transport list from json file
    public static func getTransportList(completion: @escaping (_ transportList: [Transport], _ error: Error?) -> Void) {
        
        guard let filePath = Bundle.main.url(forResource: "data",
                                             withExtension: "json") else {
            completion([], nil)
            return
        }

        do {
            let data = try Data.init(contentsOf: filePath)
            let json = try JSON(data: data)
            let list: [Transport] = try json.arrayValue.map { try Transport.parse($0) }
            completion(list, nil)
        } catch {
            completion([], error)
        }
    }
}
