//
//  ConfigOcms.swift
//  
//
//  Created by Oleg Ivanchenko on 20.04.22.
//

import Vapor

struct ConfigOcms {
    var layoutDir: String
}

struct ConfigKeyOcms: StorageKey {
    typealias Value = ConfigOcms
}

extension Application {
    var config: ConfigOcms {
        get {
            self.storage[ConfigKeyOcms.self]!
        }
        set {
            self.storage[ConfigKeyOcms.self] = newValue
        }
    }
}
