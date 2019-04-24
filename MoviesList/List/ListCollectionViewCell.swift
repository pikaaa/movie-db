//
//  ListCollectionViewCell.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 19/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favButton: UIButton!
    private var id: Int = 0
    private var movie: Movie?
    
    func configureCell(movie: Movie){
        self.title.text = movie.title
        self.id = movie.id
        self.movie = movie
        fetchImage(imageUrl: "https://image.tmdb.org/t/p/w200/\(movie.poster_path)")
        for movie in MovieListViewController.favMovies{
            if self.id == movie.id{
                favButton.setImage(UIImage(named: "Heart-filled"), for: .normal)
                return
            }
        }
        favButton.setImage(UIImage(named: "Heart-empty"), for: .normal)
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        for movie in MovieListViewController.favMovies{
            if self.id == movie.id{
                favButton.setImage(UIImage(named: "Heart-empty"), for: .normal)
                MovieListViewController.favMovies.removeAll{$0.id == id}
                return
            }
        }
        favButton.setImage(UIImage(named: "Heart-filled"), for: .normal)
        if let movie = self.movie{
            MovieListViewController.favMovies.append(movie)
        }
    }
    
    private func fetchImage(imageUrl: String){
        let url = URL(string: imageUrl)
        
        if let url = url {
            URLSession.shared.dataTask(with: url) { result in
                switch result {
                case .success(_, let data):
                    DispatchQueue.main.sync {
                        self.moviePoster.image = UIImage(data: data)
                    }
                    break
                case .failure(let error):
                    print("Image failed with error: \(error)")
                    break
                }
            }.resume()
        }
    }
}
