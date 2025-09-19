//
//  DNSBlankSystemsCodeLocationTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBlankSystemsTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest
import DNSError
@testable import DNSBlankSystems

final class DNSBlankSystemsCodeLocationTests: XCTestCase {
    private var sut: DNSBlankSystemsCodeLocation!

    override func setUp() {
        super.setUp()
        sut = DNSBlankSystemsCodeLocation(self)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Class Property Tests

    func test_domainPreface_whenAccessed_shouldReturnCorrectValue() {
        // Given
        let expectedDomainPreface = "com.doublenode.blankSystems."

        // When
        let actualDomainPreface = DNSBlankSystemsCodeLocation.domainPreface

        // Then
        XCTAssertEqual(actualDomainPreface, expectedDomainPreface)
    }

    func test_domainPreface_shouldNotBeEmpty() {
        // Given & When
        let domainPreface = DNSBlankSystemsCodeLocation.domainPreface

        // Then
        XCTAssertFalse(domainPreface.isEmpty)
        XCTAssertGreaterThan(domainPreface.count, 0)
    }

    func test_domainPreface_shouldEndWithDot() {
        // Given & When
        let domainPreface = DNSBlankSystemsCodeLocation.domainPreface

        // Then
        XCTAssertTrue(domainPreface.hasSuffix("."))
    }

    func test_domainPreface_shouldFollowReversedomainNameConvention() {
        // Given & When
        let domainPreface = DNSBlankSystemsCodeLocation.domainPreface

        // Then
        XCTAssertTrue(domainPreface.hasPrefix("com.doublenode."))
        XCTAssertTrue(domainPreface.contains("blankSystems"))
    }

    // MARK: - Inheritance Tests

    func test_dnsBlankSystemsCodeLocation_shouldInheritFromDNSCodeLocation() {
        // Given & When
        let codeLocation = sut as Any

        // Then
        XCTAssertTrue(codeLocation is DNSCodeLocation)
    }

    func test_dnsBlankSystemsCodeLocation_shouldOverrideDomainPreface() {
        // Given
        let parentDomainPreface = DNSCodeLocation.domainPreface
        let childDomainPreface = DNSBlankSystemsCodeLocation.domainPreface

        // When & Then
        XCTAssertNotEqual(parentDomainPreface, childDomainPreface)
        XCTAssertTrue(childDomainPreface.contains("blankSystems"))
    }

    // MARK: - Initialization Tests

    func test_init_whenCalled_shouldCreateInstance() {
        // Given & When
        let codeLocation = DNSBlankSystemsCodeLocation(self)

        // Then
        XCTAssertNotNil(codeLocation)
        XCTAssertTrue(codeLocation is DNSBlankSystemsCodeLocation)
        XCTAssertTrue(codeLocation is DNSCodeLocation)
    }

    func test_init_whenCalledMultipleTimes_shouldCreateDifferentInstances() {
        // Given & When
        let codeLocation1 = DNSBlankSystemsCodeLocation(self)
        let codeLocation2 = DNSBlankSystemsCodeLocation(self)

        // Then
        XCTAssertNotNil(codeLocation1)
        XCTAssertNotNil(codeLocation2)
        XCTAssertFalse(codeLocation1 === codeLocation2)
    }

    // MARK: - Extension Tests

    func test_dnsCodeLocationExtension_shouldProvideBlankSystemsTypealias() {
        // Given & When
        let codeLocationViaExtension = DNSCodeLocation.blankSystems(self)

        // Then
        XCTAssertNotNil(codeLocationViaExtension)
        XCTAssertTrue(codeLocationViaExtension is DNSBlankSystemsCodeLocation)
        XCTAssertEqual(type(of: codeLocationViaExtension).domainPreface, DNSBlankSystemsCodeLocation.domainPreface)
    }
}

// MARK: - Mock Classes for Testing

private class MockDNSBlankSystemsCodeLocation: DNSBlankSystemsCodeLocation {
    // This class tests that subclassing works correctly
    // and that the domainPreface is properly inherited
}