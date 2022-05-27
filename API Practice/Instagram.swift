//
//  Instagram.swift
//  API Practice
//
//  Created by Shien on 2022/5/26.
//

import Foundation


struct Account:Decodable {
    var graphql: Graphql
}

struct Graphql:Decodable {
    var user: IGUser
}

struct IGUser:Decodable {
    var biography: String
    var external_url: URL
    var edge_followed_by: Followed
    var edge_follow: Follow
    var full_name: String
    var profile_pic_url_hd: URL
    var username: String
    var edge_owner_to_timeline_media: TimelineMedia
}

struct Followed:Decodable {
    var count: Int
}

struct Follow:Decodable {
    var count: Int
}

struct TimelineMedia:Decodable {
    var count: Int
    var edges: [TimelineMediaEdge]
}

struct TimelineMediaEdge:Decodable {
    var node: TimelineMediaEdgeNode
}

struct TimelineMediaEdgeNode:Decodable {
    var display_url: URL?
}
