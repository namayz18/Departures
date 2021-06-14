//
//  TransportTests.swift
//  DeparturesTests
//
//  Created by Namasang Yonzan on 11/06/21.
//

import Foundation
import XCTest
@testable import Departures
@testable import SwiftyJSON
@testable import JSONParsing

class TransportTests: XCTestCase {

    func testParseJson() {
        let transport: [String: Any] = [
            "typeId": 0,
            "departureTime": "2021-07-03T14:30:00.000Z",
            "name": "Flinders",
            "latitude": -37.8181755,
            "longitude": 144.9661256,
            "isExpress": true
        ]
        let json = JSON(transport)
        XCTAssertNotNil(try Transport.parse(json))   
    }

}
