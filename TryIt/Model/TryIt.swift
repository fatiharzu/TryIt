//
//  TryIt.swift
//  TryIt
//
//  Created by imac on 20.12.22.
//

import Foundation

// Deklarieren von Variablentypen in der Bored-API

struct TryIt: Codable {
    let activity, type: String?
    let participants: Int?
    let price: Double?
    let link: String?
    let key: String?
    let accessibility: Double?
}
