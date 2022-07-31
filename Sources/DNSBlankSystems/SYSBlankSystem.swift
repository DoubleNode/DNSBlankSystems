//
//  SYSBlankSystem.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBlankSystems
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import AtomicSwift
import DNSCore
import DNSCrashNetwork
import DNSProtocols
import Foundation

open class SYSBlankSystem: NSObject, SYSPTCLSystem
{
    static public var languageCode: String {
        DNSCore.languageCode
    }

    @Atomic
    private var options: [String] = []

    override public required init() {
        super.init()
    }
    open func configure() { }

    public func checkOption(_ option: String) -> Bool {
        return self.options.contains(option)
    }
    open func enableOption(_ option: String) {
        guard !self.checkOption(option) else { return }
        self.options.append(option)
    }
    open func disableOption(_ option: String) {
        self.options.removeAll { $0 == option }
    }

    // MARK: - UIWindowSceneDelegate methods
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    open func didBecomeActive() { }
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    open func willResignActive() { }
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    open func willEnterForeground() { }
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    open func didEnterBackground() { }

    public var netConfig: NETPTCLConfig = NETCrashConfig()
}
