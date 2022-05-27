//
//  Dcard.swift
//  API Practice
//
//  Created by Shien on 2022/5/25.
//

import Foundation


struct Post: Decodable {
    var title: String
    var excerpt: String
    var anonymousSchool: Bool
    var anonymousDepartment: Bool
    var commentCount: Int
    var likeCount: Int
    var forumName: String
    var gender: String
    var school: String?
    var department: String?
    var mediaMeta: [MediaMeta?]
    var media: [Media?]
    var withImages: Bool
}

struct Media: Decodable {
    var url: String
}

struct MediaMeta: Decodable {
    var url: String
}
