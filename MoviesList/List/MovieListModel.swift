//
//  MovieListModel.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 20/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//

struct MovieList: Codable {
    var id: String?
    var items: [Movie]?
    
    var errors: [String]?
}

struct Movie: Codable{
    var vote_average: Float
    var title: String
    var popularity: Float
    var release_date: String
    var poster_path: String
    var id: Int
}
