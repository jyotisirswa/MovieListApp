//
//  MovieDetailsAppTests.swift
//  MovieListAppTests
//
//  Created by Jyoti on 08/11/2022.
//

import XCTest
@testable import MovieListApp


class MovieDetailsAppTests: XCTestCase {
    
    var presenter: MovieDetailPresenter!
    var view: MockDetailsViewController!
    var interactor: MockDetailsInteractor!
    var router : MockDetailsRouter!
    var movieList : MovieList!

    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        interactor = nil
        router = nil
    }
    
    func test_viewDidLoad_Invoke_setup_views() {
        presenter.viewDidLoad()
        XCTAssertTrue(view.isCalledSetupTableView)
    }
    
    func test_viewWillAppear_Invoke_SetUp_Views() {
        presenter.viewWillAppear()
        XCTAssertTrue(view.isCalledSetupView)
    }
}

// MARK: - Mock Classes
final class MockDetailsViewController: MovieDetailsViewControllerProtocol {
    
    var isCalledReloadData = false
    var isCalledSetupTableView = false
    var isCalledSetupView = false
    
    func reloadData() {
        isCalledReloadData = true
    }
    
    func setupTableView() {
        isCalledSetupTableView = true
    }
    
    func setUpView() {
        isCalledSetupView = true
    }
}

final class MockDetailsInteractor: MovieDetailViewInteractorProtocol {
 
}

final class MockDetailsRouter : MovieDetailRouterProtocol {
    var isRouteDetail = false

    func navigate(_ route: MovieDetailRoutes) {
        isRouteDetail = true
    }
}
