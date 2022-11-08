//
//  MovieListPresenter.swift
//  MovieListApp
//
//  Created by Jyoti on 04/11/2022.
//

import Foundation


protocol MovieListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func refreshData(movieObj : MovieList)
    func numberOfRowsInSection() -> Int
    func showActionSheet()
    func movie(_ index: Int) -> MovieList?
    func didSelectRowAt(index: Int)
}


final class MovieListPresenter : MovieListPresenterProtocol {
    
    //MARK: - Properties
    unowned var view: MovieListViewControllerProtocol?
    let router: MovieListRouterProtocol!
    let interactor: MovieListInteractorProtocol!
    private var movies: [MovieList] = []
    
    init(
        view: MovieListViewControllerProtocol,
        router: MovieListRouterProtocol,
        interactor: MovieListInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    
    func viewDidLoad() {
        view?.setupTableView()
        fetchMovies()
    }
    
    func viewWillAppear() {
        view?.setUpView()
    }
    
    func refreshData(movieObj : MovieList) {
        if let indexObj = self.movies.firstIndex(where: {$0.id == movieObj.id}) {
            movies[indexObj] = movieObj
        }
        view?.reloadData()
    }
    
    func numberOfRowsInSection() -> Int {
        return movies.count
    }
    
    func movie(_ index: Int) -> MovieList? {
        return movies[safe : index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let movieObj = movie(index) else { return }
        router.navigate(.detail(movie: movieObj))
    }
    
    private func fetchMovies() {
        view?.showLoadingView()
        interactor.fetchMoviesList()
    }
    
    func showActionSheet() {
        (view as? MovieListViewController)?.presentAlertWithTitleAndMessage(options: "Title", "Release Date", "Cancel", completion: { indexObj in
            if indexObj == 0 || indexObj == 1 {
                self.interactor.sortMoviesList(sortType: SortType.init(rawValue: indexObj) ?? .title, movies: self.movies)
            }
        })
    }
}
//MARK: - Extension +  MovieListInteractorOutputProtocol
extension MovieListPresenter : MovieListInteractorOutputProtocol {
    func sortMoviesList(result: [MovieList]?) {
        guard let sortedMovies = result else {
            return
        }
        self.movies = sortedMovies
        print(self.movies)
        view?.reloadData()
    }
    
    func fetchMoviesList(result: MovieListResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let movieResponse) :
            if let movies = movieResponse.movieList {
                self.movies = movies
                view?.reloadData()
            }
        case .failure(let error):
            print(error)
        }
    }
}
