//
//  MovieDetailsRouter.swift
//  MovieListApp
//
//  Created by Jyoti on 04/11/2022.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol: AnyObject {
    func navigate(_ route: MovieDetailRoutes)
}

enum MovieDetailRoutes {
    case detail(movieObj: MovieList)
    case openURL(playUrl: URL)
}

final class MovieDetailsViewRouter {

    //MARK: - Properties
    weak var viewController: MovieDetailsViewController?
    
    static func createModule(movie : MovieList) -> MovieDetailsViewController {
        let viewController = UIStoryboard.init(name: StoryBoard.Main.rawValue, bundle: .main).instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        let interactor = MovieDetailViewInteractor()
        let router = MovieDetailsViewRouter()
        let presenter = MovieDetailPresenter(view: viewController, router: router, interactor: interactor)
        viewController.presenter = presenter
        viewController.presenter.movieDetail = movie
        interactor.output = presenter
        router.viewController = viewController
        return viewController
    }
}

//MARK: - Extension +  MovieDetailRouterProtocol
extension MovieDetailsViewRouter: MovieDetailRouterProtocol {
    
    func navigate(_ route: MovieDetailRoutes) {
        switch route {
        case .detail(let movieObj):
            let detailVC = MovieDetailsViewRouter.createModule(movie: movieObj)
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        case .openURL(let url):
            UIApplication.shared.open(url)
        }
    }
}

