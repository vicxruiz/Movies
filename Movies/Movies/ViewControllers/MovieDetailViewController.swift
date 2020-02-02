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
    
    var networkManager: NetworkManager?
    var movie: Movie?
    var movieDetails: MovieDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayMovieDetails()
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
    
    func updateViews() {
        if let movieDetails = movieDetails {
            title = movieDetails.name
        }
    }
    
}
