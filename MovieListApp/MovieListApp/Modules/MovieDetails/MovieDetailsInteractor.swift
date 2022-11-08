//
//  MovieDetailsInteractor.swift
//  MovieListApp
//
//  Created by Jyoti on 04/11/2022.
//

import Foundation

protocol MovieDetailViewInteractorProtocol: AnyObject {
}


protocol MovieDetailViewInteractorOutputProtocol: AnyObject {
}


final class MovieDetailViewInteractor {
    var output: MovieDetailViewInteractorOutputProtocol?
}

extension MovieDetailViewInteractor : MovieDetailViewInteractorProtocol {
}
