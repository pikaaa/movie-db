//
//  MovieDetail.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 20/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//

struct MovieDetail: Codable{
    var title: String
    var tagline: String
    var overview: String
    var popularity: Float
    var release_date: String
    var backdrop_path: String
    var genres: [Genre]
    var spoken_languages: [Language]
}

struct Genre: Codable{
    var name: String
}

struct Language: Codable{
    var name: String
}
