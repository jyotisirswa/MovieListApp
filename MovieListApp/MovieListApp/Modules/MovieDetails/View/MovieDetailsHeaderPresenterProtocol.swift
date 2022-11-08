//
//  MovieDetailsHeaderPresenterProtocol.swift
//  MovieListApp
//
//  Created by Jyoti on 08/11/2022.
//

import Foundation
import UIKit

//MARK: - Protocol +  MovieDetailsHeaderPresenterProtocol
protocol MovieDetailsHeaderPresenterProtocol: AnyObject {
    func load()
    func addWatchListButtonTapped()
    func openYoutubeURL()

}

//MARK: - Protocol +  MovieDetailsHeaderPresenter
extension MovieDetailsHeaderPresenter {
    fileprivate enum Constants {
        static let addWatchList: String = "ADD TO WATCHLIST"
        static let removeWatchList: String = "REMOVE FROM WATCHLIST"
    }
}


final class MovieDetailsHeaderPresenter {
    
    weak var view: MovieDetailsHeaderViewProtocol?
    private let movie: MovieList
    
    init(view: MovieDetailsHeaderViewProtocol?, movie: MovieList) {
        self.view = view
        self.movie = movie
    }
}

//MARK: - Protocol +  MovieDetailsHeaderPresenter
extension MovieDetailsHeaderPresenter : MovieDetailsHeaderPresenterProtocol {
    func openYoutubeURL() {
        guard let urlObj = movie.trailerLinkUrl else {
            print("Url is not valid")
            return
        }
        UIApplication.shared.open(urlObj)
    }

    func addWatchListButtonTapped() {
        if let isWatchList = self.movie.watchListAdded {
            if !isWatchList {
                UserDefaults.standard.set(true, forKey: "\(self.movie.id)")
            } else {
                UserDefaults.standard.removeObject(forKey: "\(self.movie.id)")
            }
        }
        view?.setWatchListButton(movie.watchListAdded == true ? Constants.removeWatchList : Constants.addWatchList)
        NotificationCenter.default.post(name: Notification.Name("RELOAD_NOTIFICATION"), object: ["movie": movie])
    }
    func load() {
        if let movieImage = UIImage(named: "\(movie.id)") {
            view?.setMovieImage(movieImage)
        }
        view?.setTitleLabelNRating(movie.title, ratings: movie.rating)
        view?.setWatchListButton(movie.watchListAdded == true ? Constants.removeWatchList : Constants.addWatchList)
        view?.setDescription(movie.description)
        view?.setGenreNDurationLabel(movie.genre, releaseDate: movie.duration)
        view?.setAccessibilityIdentifiers()
    }
}
