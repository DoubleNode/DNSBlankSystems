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
    
    // MARK: - Domain Preface Tests
    
    func testDomainPreface() {
        let expectedPreface = "com.doublenode.blankSystems."
        let actualPreface = DNSBlankSystemsCodeLocation.domainPreface
        
        XCTAssertEqual(actualPreface, expectedPreface, "Domain preface should match expected value")
        XCTAssertTrue(actualPreface.hasSuffix("."), "Domain preface should end with a dot")
        XCTAssertTrue(actualPreface.hasPrefix("com.doublenode."), "Domain preface should start with com.doublenode.")
    }
    
    // MARK: - Type Alias Tests
    
    func testTypeAlias() {
        // Test that the type alias works correctly
        let codeLocation = DNSCodeLocation.blankSystems(self)
        XCTAssertTrue(codeLocation is DNSBlankSystemsCodeLocation, "Type alias should resolve to correct type")
    }
    
    // MARK: - Inheritance Tests
    
    func testInheritance() {
        let codeLocation = DNSBlankSystemsCodeLocation(self)
        XCTAssertTrue(codeLocation is DNSCodeLocation, "DNSBlankSystemsCodeLocation should inherit from DNSCodeLocation")
    }
    
    // MARK: - Sendable Conformance Tests
    
    func testSendableConformance() {
        // Test that the class can be used in concurrent contexts
        let expectation = XCTestExpectation(description: "Sendable test")
        
        DispatchQueue.global().async {
            let codeLocation = DNSBlankSystemsCodeLocation(self)
            let domainPreface = type(of: codeLocation).domainPreface
            XCTAssertFalse(domainPreface.isEmpty, "Domain preface should not be empty in concurrent context")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Functionality Tests
    
    func testCodeLocationFunctionality() {
        let codeLocation = DNSBlankSystemsCodeLocation(self)
        
        // Test that we can access the domain preface through the instance
        let domainPreface = type(of: codeLocation).domainPreface
        XCTAssertEqual(domainPreface, "com.doublenode.blankSystems.", "Instance should provide correct domain preface")
    }
    
    // MARK: - Integration Tests
    
    func testIntegrationWithDNSCodeLocation() {
        // Test that our code location integrates properly with the base DNSCodeLocation functionality
        let codeLocation = DNSBlankSystemsCodeLocation(self)
        
        // If DNSCodeLocation has any base functionality, test it here
        // For now, we just ensure the object is properly constructed
        XCTAssertNotNil(codeLocation, "Code location should be properly constructed")
    }
    
    // MARK: - Multiple Instance Tests
    
    func testMultipleInstances() {
        let codeLocation1 = DNSBlankSystemsCodeLocation(self)
        let codeLocation2 = DNSBlankSystemsCodeLocation(self)
        
        // Both should have the same domain preface
        XCTAssertEqual(type(of: codeLocation1).domainPreface, type(of: codeLocation2).domainPreface,
                      "Multiple instances should have the same domain preface")
        
        // But they should be different objects
        XCTAssertFalse(codeLocation1 === codeLocation2, "Multiple instances should be different objects")
    }
    
    static let allTests = [
        ("testDomainPreface", testDomainPreface),
        ("testTypeAlias", testTypeAlias),
        ("testInheritance", testInheritance),
        ("testSendableConformance", testSendableConformance),
        ("testCodeLocationFunctionality", testCodeLocationFunctionality),
        ("testIntegrationWithDNSCodeLocation", testIntegrationWithDNSCodeLocation),
        ("testMultipleInstances", testMultipleInstances),
    ]
}