//
//  ServiceManager.swift
//  MovieListApp
//
//  Created by Jyoti on 05/11/2022.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovieList(completionHandler: @escaping (MovieListResult) -> ())
    func fetchMovieDetail(movieID: Int, completionHandler: @escaping (MovieList) -> ())
}

struct MovieService: MovieServiceProtocol {
    func fetchMovieList(completionHandler: @escaping (MovieListResult) -> ()) {
        JSONManager.shared.getDatafrom(localJSON: "ListJSON", decodeToType: MovieResponse.self, completionHandler: completionHandler)
    }
    
    func fetchMovieDetail(movieID: Int, completionHandler: @escaping (MovieList) -> ()) {
        
    }
}


