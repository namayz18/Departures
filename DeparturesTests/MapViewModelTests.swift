//
//  MapViewModelTests.swift
//  DeparturesTests
//
//  Created by Namasang Yonzan on 13/06/21.
//

import Foundation
import XCTest
@testable import Departures

class MapViewModelTests: XCTestCase {

    func testFetchItems() {
        XCTAssertNotNil(MapViewModel.fetchItems(completion:))
    }

}
