//
//  SYSBlankSystem.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBlankSystems
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import AtomicSwift
import DNSError
import Foundation

// Simplified version for now - will add full protocol conformance later
open class SYSBlankSystem: NSObject {
    static public var languageCode: String {
        Locale.current.language.languageCode?.identifier ?? "en"
    }

    @Atomic private var options: [String] = []

    override public required init() {
        super.init()
        self.configure()
    }
    open func configure() { }

    public func checkOption(_ option: String) -> Bool {
        guard !option.isEmpty else { return false }
        return self.options.contains(option)
    }
    open func enableOption(_ option: String) {
        guard !option.isEmpty else { return }
        guard !self.checkOption(option) else { return }
        self.options.append(option)
    }
    open func disableOption(_ option: String) {
        guard !option.isEmpty else { return }
        self.options.removeAll { $0 == option }
    }

    // MARK: - UIWindowSceneDelegate methods
    open func didBecomeActive() { }
    open func willResignActive() { }
    open func willEnterForeground() { }
    open func didEnterBackground() { }
}
