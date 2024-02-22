//
//  Session.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import Foundation

struct Session: Hashable, Equatable {
    let date: Date
    var logs: [Log]
}
