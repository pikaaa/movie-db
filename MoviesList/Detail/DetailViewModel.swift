//
//  DetailViewModel.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 24/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//

struct DetailViewModel{
    
    func getPopularity(detail: MovieDetail?) ->  String{
        let popularity = "Popularity: "
        guard let pop = detail?.popularity else {
            return ""
        }
        
        return popularity + String(pop) + "%"
    }
    
    func getReleaseDate(detail: MovieDetail?) ->  String{
        let releaseDate = "Release date: "
        guard let date = detail?.release_date else {
            return ""
        }
        
        return releaseDate + date
    }
    
    func getGenre(detail: MovieDetail?) -> String{
        var genreLabel = "Genre: "
        guard let genres = detail?.genres, !genres.isEmpty else {
            return ""
        }
        for genre in genres {
            genreLabel.append(genre.name)
            genreLabel.append(", ")
        }
        return String(genreLabel.dropLast(2))
    }
    
    func getLanguage(detail: MovieDetail?) -> String{
        var languageLabel = "Language: "
        guard let languages = detail?.spoken_languages, !languages.isEmpty else {
            return ""
        }
        for language in languages{
            languageLabel.append(language.name)
            languageLabel.append(", ")
        }
        return String(languageLabel.dropLast(2))
    }
    
}
