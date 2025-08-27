//
//  DNSBlankSystemsCodeLocation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBlankSystems
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import DNSError

public extension DNSCodeLocation {
    typealias blankSystems = DNSBlankSystemsCodeLocation
}
open class DNSBlankSystemsCodeLocation: DNSCodeLocation, @unchecked Sendable {
    override open class var domainPreface: String { "com.doublenode.blankSystems." }
}
