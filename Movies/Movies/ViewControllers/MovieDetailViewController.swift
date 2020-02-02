//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Victor Ruiz on 2/1/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var networkManager: NetworkManager?
    var movie: Movie?
    var movieDetails: MovieDetails?
    var movieDB: MovieDB?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayMovieDetails()
        displayPoster()
    }
    
    func displayMovieDetails() {
        guard let movie = movie else {return}
        networkManager?.fetchMovieDetails(movie, completion: { (movieDetailsResult, error) in
            if let error = error  {
                print(error)
                return
            }
            if let movieDetailsResult = movieDetailsResult {
                self.movieDetails = movieDetailsResult[0]
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        })
    }
    
    func displayPoster() {
        guard let movie = movie else {return}
        networkManager?.fetchMovieFromMovieDB(movie, completion: { (movieDB, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let movieDB = movieDB {
                if let path = movieDB.poster_path {
                    DispatchQueue.main.async {
                        self.posterImageView.imageFromServerURL("https://image.tmdb.org/t/p/w500/\(path)", placeHolder: UIImage(named: "noimage"))
                    }
                }
            }
        })
    }
    
    func updateViews() {
        if let movieDetails = movieDetails {
            title = movieDetails.name
        }
    }
    
}
