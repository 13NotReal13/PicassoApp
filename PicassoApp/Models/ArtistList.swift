//
//  ArtistList.swift
//  PicassoApp
//
//  Created by Иван Семикин on 01/06/2024.
//

import Foundation

struct ArtistList: Codable {
    let artists: [Artist]
}

struct Artist: Codable {
    let name: String
    let bio: String
    let image: String
    let works: [Work]
}

struct Work: Codable {
    let title: String
    let image: String
    let info: String
}
