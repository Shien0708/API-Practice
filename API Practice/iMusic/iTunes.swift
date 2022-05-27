//
//  iTunes.swift
//  API Practice
//
//  Created by Shien on 2022/5/26.
//

import Foundation

struct Music: Decodable {
    var feed: Feed
}

struct Feed: Decodable {
    var title: String
    var results: [songResult]
}

struct songResult: Decodable {
    var artistName: String
    var name: String
    var artworkUrl100: URL
    var url: URL
}
