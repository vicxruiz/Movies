//
//  NetworkManager.swift
//  Movies
//
//  Created by Victor Ruiz on 2/1/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation


class NetworkManager {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum Endpoints: String {
        case rank = "MoviesByRank"
        case details = "MovieDetails"
        case search = "search/movie"
    }
    
    
    let dataGetter = DataGetter()
    let baseZocdocURL = URL(string: "https://interview.zocdoc.com/api/1/FEE/")!
    let baseMovieDBURL = URL(string: "https://api.themoviedb.org/3/")!
    let zocdocAuthToken = "3b502b3f-b1ff-4128-bd99-626e74836d9c"
    let movieDBAPIKey = "903fbcb91e61123c53dbcb97a317eded"
    let startIndex = 1
    let numMovies = 10
    
    func fetchTopMovies(completion: @escaping ([Movie]?,Error?) -> Void) {
        
        let MoviesByRankURL = baseZocdocURL.appendingPathComponent("\(Endpoints.rank.rawValue)")
        var components = URLComponents(url: MoviesByRankURL, resolvingAgainstBaseURL: true)
        
        let authTokenQueryItem = URLQueryItem(name: "authToken", value: zocdocAuthToken)
        let startIndexRankQueryItem = URLQueryItem(name: "startRankIndex", value: "\(startIndex)")
        let numMoviesQueryItem = URLQueryItem(name: "numMovies", value: "\(numMovies)")
        
        components?.queryItems = [authTokenQueryItem, startIndexRankQueryItem, numMoviesQueryItem]
        
        guard let url = components?.url else {return}
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        dataGetter.fetchData(with: request) { (_, data, error) in

            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                print("no data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode([Movie].self, from: data)
                completion(data, nil)
            } catch {
                print("error decoding data: \(error)")
                completion(nil, error)
            }
        }
    }
    
    func fetchMovieDetails(_ movie: Movie, completion: @escaping ([MovieDetails]?,Error?) -> Void)  {
        let movieDetailsURL = baseZocdocURL.appendingPathComponent("\(Endpoints.details.rawValue)")
        var components = URLComponents(url: movieDetailsURL, resolvingAgainstBaseURL: true)
        
        let authTokenQueryItem = URLQueryItem(name: "authToken", value: zocdocAuthToken)
        let movieIdsQueryItem = URLQueryItem(name: "movieIds", value: "\(movie.id)")
        
        components?.queryItems = [authTokenQueryItem, movieIdsQueryItem]
        
        guard let url = components?.url else {return}
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        dataGetter.fetchData(with: request) { (_, data, error) in

            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                print("no data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode([MovieDetails].self, from: data)
                completion(data, nil)
            } catch {
                print("error decoding data: \(error)")
                completion(nil, error)
            }
        }
        
    }
    
    func fetchMovieFromMovieDB(_ movie: Movie, completion: @escaping (MovieDB?,Error?) -> Void) {
        let movieDBURL = baseMovieDBURL.appendingPathComponent("\(Endpoints.search.rawValue)")
        var components = URLComponents(url: movieDBURL, resolvingAgainstBaseURL: true)
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "\(movieDBAPIKey)")
        let movieName = cleanUpMovieTitle(movie: movie)
        let queryQueryItem = URLQueryItem(name: "query", value: "\(movieName)")
        components?.queryItems = [apiKeyQueryItem, queryQueryItem]
               
        guard let url = components?.url else {return}
        print(url)
               
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        dataGetter.fetchData(with: request) { (_, data, error) in

            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                print("no data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(MovieSearch.self, from: data)
                let movieDB = data.results[0]
                completion(movieDB, nil)
            } catch {
                print("error decoding data: \(error)")
                completion(nil, error)
            }
        }

    }
}

extension NetworkManager {
    func cleanUpMovieTitle(movie: Movie) -> String {
        var movieName = movie.name
        if movie.name.contains("(") {
            for _ in 1...7 {
                movieName.removeLast()
            }
        }
        return movieName
    }
}
