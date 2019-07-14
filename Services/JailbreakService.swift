//
//  JailbreakService.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import UIKit

protocol JailbreakService {
    var isJailbroken: Bool { get }
}

final class JailbreakServiceImpl: JailbreakService {
    var isJailbroken: Bool {
        guard let cydiaUrlScheme = URL(string: "cydia://package/com.example.package") else {
            return inspectIsJailbroken()
        }

        let application = UIApplication.shared
        return application.canOpenURL(cydiaUrlScheme) || inspectIsJailbroken()
    }

    private func inspectIsJailbroken() -> Bool {
        #if DEBUG
        return false
        #endif

        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            fileManager.fileExists(atPath: "/bin/bash") ||
            fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
            fileManager.fileExists(atPath: "/etc/apt") ||
            fileManager.fileExists(atPath: "/usr/bin/ssh") {
            return true
        }

        if canOpen("/Applications/Cydia.app") ||
            canOpen("/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            canOpen("/bin/bash") ||
            canOpen("/usr/sbin/sshd") ||
            canOpen("/etc/apt") ||
            canOpen("/usr/bin/ssh") {
            return true
        }

        let path = "/private/" + UUID().uuidString
        do {
            try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            try fileManager.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }

    private func canOpen(_ path: String) -> Bool {
        let file = fopen(path, "r")
        guard file != nil else {
            return false
        }
        fclose(file)
        return true
    }
}
