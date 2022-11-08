//
//  MovieListRouter.swift
//  MovieListApp
//
//  Created by Jyoti on 04/11/2022.
//

import Foundation
import UIKit

protocol MovieListRouterProtocol: AnyObject {
    func navigate(_ route: MovieListRoutes)
}

enum MovieListRoutes {
    case detail(movie: MovieList)
}


final class MovieListRouter {
    
    //MARK: - Properties
    weak var viewController: MovieListViewController?
    
    static func createModule(movieListVCRef: MovieListViewController){
        let interactor = ListInteractor()
        let router = MovieListRouter()
        let presenter = MovieListPresenter(view: movieListVCRef, router: router, interactor: interactor)
        movieListVCRef.presenter = presenter
        interactor.output = presenter
        router.viewController = movieListVCRef
    }
}

//MARK: - Extension +  MovieListRouterProtocol
extension MovieListRouter : MovieListRouterProtocol {
    func navigate(_ route: MovieListRoutes) {
        switch route {
        case .detail(let movieObj):
            let detailVC = MovieDetailsViewRouter.createModule(movie: movieObj)
            
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
