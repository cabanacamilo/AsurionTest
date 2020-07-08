//
//  AsurionTestTests.swift
//  AsurionTestTests
//
//  Created by Camilo Cabana on 8/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import XCTest
@testable import AsurionTest

class AsurionTestTests: XCTestCase {
    
    func testLoadConfigJson() {
        let manager = SettingsManager()
        manager.loadData { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "cannotFindData")
            case .success(let settings):
                XCTAssertEqual(settings.workHours, "M-F 9:00 - 18:00")
            }
        }
    }
    
    func testLoadPetsJson() {
        let manager = PetsManager()
        manager.loadData { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "cannotFindData")
            case .success(let pets):
                XCTAssertEqual(pets[3].title, "Goldfish")
                XCTAssertEqual(pets[0].title, "Cat")
            }
        }
    }
}
