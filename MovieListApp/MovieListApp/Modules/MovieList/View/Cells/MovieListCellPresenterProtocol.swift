//
//  MovieListCellPresenterProtocol.swift
//  MovieListApp
//
//  Created by Jyoti on 05/11/2022.
//

import Foundation
import UIKit

protocol MovieListCellPresenterProtocol: AnyObject {
    func load()
}

final class MovieListCellPresenter {
    //MARK: - Properties
    weak var view: MovieListCellProtocol?
    private let movie: MovieList
    
    init(view: MovieListCellProtocol?, movie: MovieList) {
        self.view = view
        self.movie = movie
    }
}

//MARK: - Extension + MovieListCellPresenterProtocol
extension MovieListCellPresenter : MovieListCellPresenterProtocol {
    func load() {
        view?.setTitleLabel(movie.title)
        if let movieImage = UIImage(named: "\(movie.id)") {
            view?.setMovieImage(movieImage)
        }
        view?.setDurationNGenreLabel("\(movie.duration) -  \(movie.genre)")
        view?.setWatchListButton(movie.watchListAdded ?? false)
        view?.setAccessibilityIdentifiers()
    }
}
