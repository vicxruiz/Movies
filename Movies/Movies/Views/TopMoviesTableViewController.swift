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
    
    var movies: [Movie] = []
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    func fetchMovies() {
        networkManager.fetchTopMovies { (movies, error) in
            if let error = error {
                print(error)
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

