//
//  ErrorMessages.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 23/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//

enum ErrorState: String {
    case noFav = "There are no favourite movies yet. You can go to Home and mark as favourite!!"
    case notused = "We're trying to load movies for you!! Hang on with us!!"
    case noMovies = "Oops!! No movies found!! Please try again after a while.."
    case noSearchResults = "No matching results found!!"
    case noDetail = "Oops! Something went wrong. Please try again after a while.."
}
