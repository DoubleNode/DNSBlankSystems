//
//  SimpleSystemTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBlankSystemsTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest
@testable import DNSBlankSystems

final class SimpleSystemTests: XCTestCase {
    private var sut: SYSBlankSystem!

    override func setUp() {
        super.setUp()
        sut = SYSBlankSystem()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_init_shouldNotBeNil() {
        // Given & When
        let system = SYSBlankSystem()

        // Then
        XCTAssertNotNil(system)
    }

    func test_checkOption_withNewOption_shouldReturnFalse() {
        // Given
        let optionName = "testOption"

        // When
        let result = sut.checkOption(optionName)

        // Then
        XCTAssertFalse(result)
    }

    func test_enableOption_withNewOption_shouldEnableOption() {
        // Given
        let optionName = "testOption"

        // When
        sut.enableOption(optionName)

        // Then
        XCTAssertTrue(sut.checkOption(optionName))
    }

    func test_disableOption_withEnabledOption_shouldDisableOption() {
        // Given
        let optionName = "testOption"
        sut.enableOption(optionName)

        // When
        sut.disableOption(optionName)

        // Then
        XCTAssertFalse(sut.checkOption(optionName))
    }

    func test_netConfig_shouldNotBeNil() {
        // Given & When & Then
        XCTAssertNotNil(sut.netConfig)
    }
}