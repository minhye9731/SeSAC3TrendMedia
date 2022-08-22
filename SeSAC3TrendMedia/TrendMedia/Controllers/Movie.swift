//
//  Movie.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/20/22.
//

import Foundation

struct Movie {
    var title: String
    var releaseDate: String
    var runtime: Int
    var overview: String
    var rate: Double
    
    var movieDescriptoin: String {
        // get만 사용하면 get도 생략 가능
        get {
            "\(releaseDate) | \(runtime)분 | \(rate)점"
            // return문이 한 줄 짜리면 return 생략 가능
        }
    }
}

class User {
    internal init(name: String, age: Int, rate: Double, gender: Bool) {
        self.name = name
        self.age = age
        self.rate = rate
        self.gender = gender
    }
    
    var name: String
    var age: Int
    var rate: Double
    var gender: Bool
    
}

