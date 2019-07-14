//
//  TokenHolder.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/12/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

final class TokenHolder {
    private(set) var token: String? = "f02ccede4780a9aede127564b44692df"

    func updateToken(_ newToken: String) {
        token = newToken
    }

    func clearToken() {
        token = nil
    }
}
