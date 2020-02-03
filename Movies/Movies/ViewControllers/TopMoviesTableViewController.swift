//
//  TopMoviesTableViewController.swift
//  Movies
//
//  Created by Victor Ruiz on 2/1/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation
import UIKit

class TopMoviesTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var movies: [Movie] = []
    let networkManager = NetworkManager()
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMovies()
    }
    
    //MARK: Helper Functions
    
    func displayMovies() {
        networkManager.fetchTopMovies { (movies, error) in
            if let error = error {
                DispatchQueue.main.async {
                    Service.showAlert(on: self, style: .alert, title: "Error fetching top movies", message: error.localizedDescription)
                }
                return
            }
            if let movies = movies {
                self.movies = movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: Data Source

extension TopMoviesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopMoviesCell", for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.name
        return cell
    }
}

//MARK: Segues

extension TopMoviesTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetialSegue" {
            guard let destinationVC = segue.destination as? MovieDetailViewController else {
                print("no destination")
                return
            }
            guard let indexPath = tableView.indexPathForSelectedRow else {
                print("no indexPath")
                return
            }
            destinationVC.networkManager = networkManager
            destinationVC.movie = movies[indexPath.row]
        }
    }
}


