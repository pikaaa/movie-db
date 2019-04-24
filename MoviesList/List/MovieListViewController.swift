//
//  MovieListViewController.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 19/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK:- Variables
    private let itemsPerRow: CGFloat = 2
    private let padding: CGFloat = 16
    private var movies = [Movie]()
    private var id = 1
    private var filteredResults = [Movie]()
    static var favMovies = [Movie]()
    private var favShown = false
    lazy private var utils: Utils = Utils()

    //MARK:- Outlets
    @IBOutlet weak var showAllFavButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var searchBarHeightContraint: NSLayoutConstraint!
    
    @IBAction func showAllFav(_ sender: UIBarButtonItem) {
        if favShown{
            filteredResults = movies
            collectionView.reloadData()
            self.title = "Movie List"
            showAllFavButton.title = "Favourites"
            searchBarHeightContraint.constant = 56
            utils.hideErrorView(view: self.view)
        }else {
            if MovieListViewController.favMovies.isEmpty{
                utils.showErrorView(errMessage: ErrorState.noFav.rawValue, view: self.view)
            }else {
                filteredResults = MovieListViewController.favMovies
                collectionView.reloadData()
            }
            self.title = "Favourites"
            showAllFavButton.title = "Home"
            searchBarHeightContraint.constant = 0
        }
        favShown = !favShown
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieList()
        collectionView.prefetchDataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !movies.isEmpty{
            self.activityLoader.isHidden = true
        }
    }
    
    //MARK:- Helper methods
    private func fetchMovieList() {
        let url = URL(string: "https://api.themoviedb.org/3/list/1?page=\(id)&api_key=07fce892533347ccbcac616599c223e5&language=english&sort_by=vote_average.desc")!
        
        
        URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(_, let data):
                let list = try! JSONDecoder().decode(MovieList.self, from: data)
                if list.items?.count ?? 0 > 1{
                    self.movies = self.movies + list.items!
                    self.filteredResults = self.movies
                    
                        DispatchQueue.main.sync {
                            self.activityLoader.isHidden = true
                            self.collectionView.reloadData()
                            self.id = self.id + 1
                        }
                    
                } else {
                    if self.movies.isEmpty{
                        self.utils.showErrorView(errMessage: nil, view: self.view)
                    }
                }
               
            case .failure(_):
                DispatchQueue.main.sync {
                    self.activityLoader.isHidden = true
                    if self.movies.isEmpty{
                        self.utils.showErrorView(errMessage: ErrorState.noMovies.rawValue, view: self.view)
                    }
                }
            }
        }.resume()
    }
    
    //MARK:- Collection view delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as!
        ListCollectionViewCell
        cell.configureCell(movie: filteredResults[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC: DetailViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.id = filteredResults[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout delegates
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = padding * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + 0.47 * widthPerItem + 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
}

extension MovieListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredResults = movies
            utils.hideErrorView(view: self.view)
            collectionView.reloadData()
        }
        
        let filteredMovies = movies.filter{ $0.title.lowercased().contains(searchText.lowercased())  }
        if !filteredMovies.isEmpty{
            filteredResults = filteredMovies
            collectionView.reloadData()
            utils.hideErrorView(view: self.view)
        } else{
            utils.showErrorView(errMessage: ErrorState.noSearchResults.rawValue, yIndex: 120, view: self.view)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        utils.hideErrorView(view: self.view)
        filteredResults = movies
        searchBar.endEditing(true)
        searchBar.text = ""
        searchBar.placeholder = "Search with movie name"
        collectionView.reloadData()
    }
}

extension MovieListViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths{
            if index.row + Int(itemsPerRow) >= filteredResults.count{
                fetchMovieList()
                return
            }
        }
    }
}
