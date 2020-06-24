//
//  DNSBlankSystem.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBlankSystems
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import DNSProtocols

public enum DNSBlankSystemsError: Error
{
    case notImplemented(domain: String, file: String, line: String, method: String)
}
