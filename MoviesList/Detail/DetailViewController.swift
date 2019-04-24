//
//  DetailViewController.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 20/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    enum Rows: Int, CaseIterable{
        case genre = 0, popularity, language, releaseDate, overView
    }
    
    var id = Int()
    var detail: MovieDetail?
    let detailViewModel = DetailViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var tagline: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        fetchMovieDetail()
    }
    
    //MARK:- Helper methods
    private func fetchMovieDetail() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=07fce892533347ccbcac616599c223e5")!
        
        URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(_, let data):
                let detail = try! JSONDecoder().decode(MovieDetail.self, from: data)
                self.fetchImage(poster: detail.backdrop_path)
                DispatchQueue.main.sync {
                    self.activityLoader.isHidden = true
                    self.detail = detail
                    self.title = detail.title
                    self.tagline.text = detail.tagline
                    self.tableView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.sync {
                    self.activityLoader.isHidden = true
                    Utils().showErrorView(errMessage: nil, view: self.view)
                }
                break
            }
        }.resume()
    }
    
    private func fetchImage(poster: String){
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)")
        
        if let url = url {
            URLSession.shared.dataTask(with: url) { result in
                switch result {
                case .success(_, let data):
                    DispatchQueue.main.sync {
                        self.movieImage.image = UIImage(data: data)
                    }
                case .failure(_):
                    break
                }
            }.resume()
        }
    }
    
    //MARK:- TableView delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell") as! MovieDetailTableViewCell
        switch indexPath.row {
        case Rows.genre.rawValue:
            cell.configureCell(label: detailViewModel.getGenre(detail: detail))
            return cell
        case Rows.language.rawValue:
            cell.configureCell(label: detailViewModel.getLanguage(detail: detail))
            return cell
        case Rows.popularity.rawValue:
            cell.configureCell(label: detailViewModel.getPopularity(detail: detail))
            return cell
        case Rows.releaseDate.rawValue:
            cell.configureCell(label: detailViewModel.getReleaseDate(detail: detail))
            return cell
        case Rows.overView.rawValue:
            cell.configureCell(label: "\(detail?.overview ?? "")")
            return cell
        default:
            return UITableViewCell()
        }
    }
}
