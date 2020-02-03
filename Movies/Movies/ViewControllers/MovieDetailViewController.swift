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
    
    //MAKR: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var collecitonView: UICollectionView!
    
    
    //MARK: - Properties
    
    var networkManager: NetworkManager?
    var movie: Movie?
    var movieDetails: MovieDetails?
    var movieDB: MovieDB?
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collecitonView.delegate = self
        collecitonView.dataSource = self
        setupNavigationBar()
        displayMovieDetails()
        displayPoster()
    }
    
    //MARK: - Helper functions
    
    func displayMovieDetails() {
        guard let movie = movie, let networkManager = networkManager else {return}
        networkManager.fetchMovieDetails(movie, completion: { (movieDetailsResult, error) in
            if let error = error  {
                print(error)
                return
            }
            if let movieDetailsResult = movieDetailsResult {
                self.movieDetails = movieDetailsResult[0]
                DispatchQueue.main.async {
                    self.updateViews()
                    self.collecitonView.reloadData()
                }
            }
        })
    }
    
    func displayPoster() {
        guard let movie = movie, let networkManager = networkManager else {return}
        networkManager.fetchMovieFromMovieDB(movie, completion: { (movieDB, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let movieDB = movieDB {
                DispatchQueue.main.async {
                    if let path = movieDB.posterPath {
                        self.posterImageView.imageFromServerURL("https://image.tmdb.org/t/p/w500/\(path)", placeHolder: UIImage(named: "noimage"))
                    }
                    self.ratingLabel.text = "\(movieDB.voteAverage)"
                }
            }
        })
    }
    
    func updateViews() {
        if let movieDetails = movieDetails {
            titleLabel.text = movieDetails.name
            titleLabel.isHidden = false
            descriptionLabel.text = movieDetails.description
            lengthLabel.text = movieDetails.duration
            lengthLabel.isHidden = false
            directorLabel.text = movieDetails.director
        }
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @IBAction func buyTicketsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "BuySegue", sender: self)
    }
    
}

//MARK: - Data Source

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetails?.actors.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameCell", for: indexPath) as? ActorsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let movieDetails = movieDetails {
            let actor = movieDetails.actors[indexPath.row]
            cell.actorName = actor
        }
        
        return cell
    }
}
