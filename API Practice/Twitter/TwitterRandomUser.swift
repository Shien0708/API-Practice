//
//  TwitterRandomUser.swift
//  API Practice
//
//  Created by Shien on 2022/5/26.
//

import Foundation

struct RandomUsers: Decodable {
    var results: [Results]
}

struct Results: Decodable {
    var name: Name
    var location: Location
    var email: String
    var login: Login
    var dob: Dob
    var phone: String
    var picture: Picture
}

struct Name: Decodable {
    var title: String
    var first: String
    var last: String
}

struct Location: Decodable {
    var street: Street
    var city: String
    var country: String
}

struct Street: Decodable {
    var number: Int
    var name: String
}

struct Login: Decodable {
    var username: String
    var password: String
}

struct Dob: Decodable {
    var date: Date
    var age: Int
}

struct Picture: Decodable {
    var large: String
    var medium: String
}
