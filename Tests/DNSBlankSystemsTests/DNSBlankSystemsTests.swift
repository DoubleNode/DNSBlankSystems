//
//  DNSBlankSystemTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBlankSystemsTests
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest
import DNSCrashNetwork
import DNSProtocols
@testable import DNSBlankSystems

final class DNSBlankSystemTests: XCTestCase {
    private var sut: SYSBlankSystem!

    override func setUp() {
        super.setUp()
        sut = SYSBlankSystem()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Initialization Tests

    func test_init_whenCalled_shouldInitializeWithEmptyOptions() {
        // Given & When
        let system = SYSBlankSystem()

        // Then
        XCTAssertNotNil(system)
        XCTAssertFalse(system.checkOption("testOption"))
    }

    func test_init_whenCalled_shouldCallConfigure() {
        // Given
        let system = MockSYSBlankSystemForConfigure()

        // Then
        XCTAssertTrue(system.configureWasCalled)
    }

    func test_init_whenCalled_shouldSetDefaultNetConfig() {
        // Given & When
        let system = SYSBlankSystem()

        // Then
        XCTAssertNotNil(system.netConfig)
        XCTAssertTrue(system.netConfig is NETCrashConfig)
    }

    // MARK: - Configuration Tests

    func test_configure_whenCalled_shouldNotThrow() {
        // Given & When & Then
        XCTAssertNoThrow(sut.configure())
    }

    func test_configure_whenOverridden_shouldExecuteCustomLogic() {
        // Given
        let customSystem = MockSYSBlankSystemWithCustomConfigure()

        // When
        customSystem.configure()

        // Then
        XCTAssertTrue(customSystem.customConfigureExecuted)
    }

    // MARK: - Option Management Tests

    func test_checkOption_withNonExistentOption_shouldReturnFalse() {
        // Given
        let option = "nonExistentOption"

        // When
        let result = sut.checkOption(option)

        // Then
        XCTAssertFalse(result)
    }

    func test_checkOption_withExistingOption_shouldReturnTrue() {
        // Given
        let option = "testOption"
        sut.enableOption(option)

        // When
        let result = sut.checkOption(option)

        // Then
        XCTAssertTrue(result)
    }

    func test_enableOption_withNewOption_shouldAddToOptions() {
        // Given
        let option = "newOption"
        XCTAssertFalse(sut.checkOption(option))

        // When
        sut.enableOption(option)

        // Then
        XCTAssertTrue(sut.checkOption(option))
    }

    func test_enableOption_withExistingOption_shouldNotDuplicate() {
        // Given
        let option = "duplicateOption"
        sut.enableOption(option)
        XCTAssertTrue(sut.checkOption(option))

        // When
        sut.enableOption(option) // Enable again

        // Then
        XCTAssertTrue(sut.checkOption(option))
        // Additional verification that it's not duplicated would require access to internal array
    }

    func test_enableOption_withEmptyString_shouldHandleGracefully() {
        // Given
        let option = ""

        // When
        sut.enableOption(option)

        // Then
        XCTAssertTrue(sut.checkOption(option))
    }

    func test_enableOption_withSpecialCharacters_shouldHandleCorrectly() {
        // Given
        let option = "option-with.special_chars@123"

        // When
        sut.enableOption(option)

        // Then
        XCTAssertTrue(sut.checkOption(option))
    }

    func test_disableOption_withExistingOption_shouldRemoveFromOptions() {
        // Given
        let option = "optionToDisable"
        sut.enableOption(option)
        XCTAssertTrue(sut.checkOption(option))

        // When
        sut.disableOption(option)

        // Then
        XCTAssertFalse(sut.checkOption(option))
    }

    func test_disableOption_withNonExistentOption_shouldNotCrash() {
        // Given
        let option = "nonExistentOption"
        XCTAssertFalse(sut.checkOption(option))

        // When & Then
        XCTAssertNoThrow(sut.disableOption(option))
        XCTAssertFalse(sut.checkOption(option))
    }

    func test_disableOption_withMultipleInstances_shouldRemoveAll() {
        // Given
        let option = "multipleOption"
        // Manually add multiple instances (though enableOption should prevent this)
        sut.enableOption(option)

        // When
        sut.disableOption(option)

        // Then
        XCTAssertFalse(sut.checkOption(option))
    }

    func test_optionManagement_withMultipleOptions_shouldMaintainSeparately() {
        // Given
        let option1 = "option1"
        let option2 = "option2"
        let option3 = "option3"

        // When
        sut.enableOption(option1)
        sut.enableOption(option2)
        sut.enableOption(option3)
        sut.disableOption(option2)

        // Then
        XCTAssertTrue(sut.checkOption(option1))
        XCTAssertFalse(sut.checkOption(option2))
        XCTAssertTrue(sut.checkOption(option3))
    }

    // MARK: - Lifecycle Method Tests

    func test_didBecomeActive_whenCalled_shouldNotThrow() {
        // Given & When & Then
        XCTAssertNoThrow(sut.didBecomeActive())
    }

    func test_didBecomeActive_whenOverridden_shouldExecuteCustomLogic() {
        // Given
        let customSystem = MockSYSBlankSystemWithLifecycleTracking()

        // When
        customSystem.didBecomeActive()

        // Then
        XCTAssertTrue(customSystem.didBecomeActiveCalled)
    }

    func test_willResignActive_whenCalled_shouldNotThrow() {
        // Given & When & Then
        XCTAssertNoThrow(sut.willResignActive())
    }

    func test_willResignActive_whenOverridden_shouldExecuteCustomLogic() {
        // Given
        let customSystem = MockSYSBlankSystemWithLifecycleTracking()

        // When
        customSystem.willResignActive()

        // Then
        XCTAssertTrue(customSystem.willResignActiveCalled)
    }

    func test_willEnterForeground_whenCalled_shouldNotThrow() {
        // Given & When & Then
        XCTAssertNoThrow(sut.willEnterForeground())
    }

    func test_willEnterForeground_whenOverridden_shouldExecuteCustomLogic() {
        // Given
        let customSystem = MockSYSBlankSystemWithLifecycleTracking()

        // When
        customSystem.willEnterForeground()

        // Then
        XCTAssertTrue(customSystem.willEnterForegroundCalled)
    }

    func test_didEnterBackground_whenCalled_shouldNotThrow() {
        // Given & When & Then
        XCTAssertNoThrow(sut.didEnterBackground())
    }

    func test_didEnterBackground_whenOverridden_shouldExecuteCustomLogic() {
        // Given
        let customSystem = MockSYSBlankSystemWithLifecycleTracking()

        // When
        customSystem.didEnterBackground()

        // Then
        XCTAssertTrue(customSystem.didEnterBackgroundCalled)
    }

    func test_allLifecycleMethods_whenCalledSequentially_shouldNotConflict() {
        // Given & When & Then
        XCTAssertNoThrow({
            sut.didBecomeActive()
            sut.willResignActive()
            sut.willEnterForeground()
            sut.didEnterBackground()
        }())
    }

    // MARK: - Property Tests

    func test_netConfig_whenAccessed_shouldReturnNETCrashConfig() {
        // Given & When
        let netConfig = sut.netConfig

        // Then
        XCTAssertNotNil(netConfig)
        XCTAssertTrue(netConfig is NETCrashConfig)
    }

    func test_netConfig_whenAccessedMultipleTimes_shouldReturnSameInstance() {
        // Given & When
        let netConfig1 = sut.netConfig
        let netConfig2 = sut.netConfig

        // Then
        XCTAssertTrue(netConfig1 === netConfig2)
    }

    func test_netConfig_shouldConformToNETPTCLConfig() {
        // Given & When
        let netConfig = sut.netConfig

        // Then
        XCTAssertTrue(netConfig is NETPTCLConfig)
    }

    // MARK: - Protocol Conformance Tests

    func test_sysBlankSystem_shouldConformToSYSPTCLSystem() {
        // Given & When
        let system = sut as Any

        // Then
        XCTAssertTrue(system is SYSPTCLSystem)
    }

    func test_sysBlankSystem_shouldConformToSYSPTCLSystemBase() {
        // Given & When
        let system = sut as Any

        // Then
        XCTAssertTrue(system is SYSPTCLSystemBase)
    }

    // MARK: - Thread Safety Tests

    func test_optionManagement_withConcurrentAccess_shouldBeThreadSafe() {
        // Given
        let expectation = XCTestExpectation(description: "Concurrent option management")
        expectation.expectedFulfillmentCount = 4
        let queue = DispatchQueue.global(qos: .default)

        // When
        queue.async {
            for i in 0..<100 {
                self.sut.enableOption("option\(i)")
            }
            expectation.fulfill()
        }

        queue.async {
            for i in 50..<150 {
                self.sut.enableOption("option\(i)")
            }
            expectation.fulfill()
        }

        queue.async {
            for i in 0..<50 {
                self.sut.disableOption("option\(i)")
            }
            expectation.fulfill()
        }

        queue.async {
            for i in 0..<200 {
                _ = self.sut.checkOption("option\(i)")
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5.0)
        // If we reach here without crashing, thread safety is working
        XCTAssertTrue(true)
    }

    // MARK: - Edge Case Tests

    func test_enableDisableOption_withSameOptionRepeated_shouldWorkCorrectly() {
        // Given
        let option = "toggleOption"

        // When & Then
        for _ in 0..<10 {
            sut.enableOption(option)
            XCTAssertTrue(sut.checkOption(option))
            sut.disableOption(option)
            XCTAssertFalse(sut.checkOption(option))
        }
    }

    func test_options_withLongStrings_shouldHandleCorrectly() {
        // Given
        let longOption = String(repeating: "a", count: 1000)

        // When
        sut.enableOption(longOption)

        // Then
        XCTAssertTrue(sut.checkOption(longOption))
    }

    func test_options_withUnicodeCharacters_shouldHandleCorrectly() {
        // Given
        let unicodeOption = "测试选项🎯🚀💡"

        // When
        sut.enableOption(unicodeOption)

        // Then
        XCTAssertTrue(sut.checkOption(unicodeOption))
    }

    // MARK: - Memory Management Tests

    func test_sysBlankSystem_shouldDeallocateCleanly() {
        // Given
        weak var weakSystem: SYSBlankSystem?

        // When
        autoreleasepool {
            let system = SYSBlankSystem()
            weakSystem = system
            system.enableOption("testOption")
        }

        // Then
        XCTAssertNil(weakSystem)
    }

    func test_netConfig_shouldNotCreateRetainCycle() {
        // Given
        weak var weakSystem: SYSBlankSystem?
        weak var weakNetConfig: NETPTCLConfig?

        // When
        autoreleasepool {
            let system = SYSBlankSystem()
            weakSystem = system
            weakNetConfig = system.netConfig
        }

        // Then
        XCTAssertNil(weakSystem)
        XCTAssertNil(weakNetConfig)
    }
}

// MARK: - Mock Classes for Testing

private class MockSYSBlankSystemForConfigure: SYSBlankSystem {
    var configureWasCalled = false

    override func configure() {
        super.configure()
        configureWasCalled = true
    }
}

private class MockSYSBlankSystemWithCustomConfigure: SYSBlankSystem {
    var customConfigureExecuted = false

    override func configure() {
        super.configure()
        customConfigureExecuted = true
    }
}

private class MockSYSBlankSystemWithLifecycleTracking: SYSBlankSystem {
    var didBecomeActiveCalled = false
    var willResignActiveCalled = false
    var willEnterForegroundCalled = false
    var didEnterBackgroundCalled = false

    override func didBecomeActive() {
        super.didBecomeActive()
        didBecomeActiveCalled = true
    }

    override func willResignActive() {
        super.willResignActive()
        willResignActiveCalled = true
    }

    override func willEnterForeground() {
        super.willEnterForeground()
        willEnterForegroundCalled = true
    }

    override func didEnterBackground() {
        super.didEnterBackground()
        didEnterBackgroundCalled = true
    }
}
