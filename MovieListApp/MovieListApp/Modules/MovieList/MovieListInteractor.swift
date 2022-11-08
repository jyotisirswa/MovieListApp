//
//  MovieListInteractor.swift
//  MovieListApp
//  Created by Jyoti on 04/11/2022.
//

import Foundation

//MARK: - Protocols +  MovieListInteractorProtocol
protocol MovieListInteractorProtocol: AnyObject {
    func fetchMoviesList()
    func sortMoviesList(sortType : SortType, movies :  [MovieList])

}

//MARK: - Protocols +  MovieListInteractorOutputProtocol
protocol MovieListInteractorOutputProtocol: AnyObject {
    func fetchMoviesList(result: MovieListResult)
    func sortMoviesList(result: [MovieList]?)
}

typealias MovieListResult = Result<MovieResponse, JSONParseError>
fileprivate var movieService: MovieServiceProtocol = MovieService()

final class ListInteractor {
    var output: MovieListInteractorOutputProtocol?
}

//MARK: - Extension +  MovieListInteractorProtocol
extension ListInteractor: MovieListInteractorProtocol {
    func sortMoviesList(sortType : SortType, movies :  [MovieList]) {
        switch sortType {
        case .title :
            self.output?.sortMoviesList(result: (movies.sorted(\.title)))
        case .releaseDate :
            print((movies.sorted(\.releaseDateObj!)))
            print(movies.map{$0.releaseDateObj})
            self.output?.sortMoviesList(result: (movies.sorted(\.releaseDateObj!)))
        }
    }
    
    func fetchMoviesList() {
        movieService.fetchMovieList{ [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMoviesList(result: result)
        }
    }
}
