//
//  MovieListAppTests.swift
//  MovieListAppTests
//
//  Created by Jyoti on 04/11/2022.
//

import XCTest
@testable import MovieListApp

class MovieListAppTests: XCTestCase {
    
    var presenter: MovieListPresenter!
    var view: MockListViewController!
    var interactor: MockListInteractor!
    var router: MockListRouter!
    
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
    
    // MARK: - Test Methods
    func test_viewDidLoad_Invoke_SetUp_Views() {
        presenter.viewDidLoad()
        XCTAssertTrue(view.isCalledSetupTableView)
        XCTAssertTrue(view.isCalledShowLoading)
    }
    
    func test_viewWillAppear_Invoke_SetUp_Views() {
        presenter.viewWillAppear()
        XCTAssertTrue(view.isCalledSetupView)
    }
    
    func test_view_methods_with_no_data() {
        presenter.viewDidLoad()
        presenter.fetchMoviesList(result: .failure(JSONParseError.fileNotFound))
        
        XCTAssertFalse(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        
        XCTAssertEqual(presenter.numberOfRowsInSection(), 0)
        XCTAssertEqual(presenter.movie(0)?.id, nil)
    }
    
    func test_viewDidLoad_Invoke_Fetch_Datas_Succes_Status_Empty_Data() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.isFetchMoviesCalled)
        
        presenter.fetchMoviesList(result: .success(.init(movieList: nil)))
        
        XCTAssertFalse(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        
        XCTAssertEqual(presenter.movie(0)?.id, nil)
        XCTAssertEqual(presenter.numberOfRowsInSection(), 0)
    }
    
    func test_viewDidLoad_Invoke_Fetch_Datas_Succes_Status_Filled_Data() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.isFetchMoviesCalled)
        presenter.fetchMoviesList(result: .success(createListResponse()))
        XCTAssertTrue(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        XCTAssertEqual(presenter.movie(0)?.id, 1)
        XCTAssertEqual(presenter.numberOfRowsInSection(), 1)
    }
    
    func test_didSelectRowAt_no_movie_data() {
        presenter.viewDidLoad()
        presenter.didSelectRowAt(index: 0)
    }
    
    func test_navigate_detail_with_table_view_selection() {
        presenter.viewDidLoad()
        presenter.didSelectRowAt(index: 0)
        //XCTAssertTrue(router.isRouteDetail)
    }
    
    // MARK: - Private Methods
    private func createListResponse() -> MovieResponse {
        .init(movieList :
                [.init(title : "Tenet",
                       id : 1,
                       description : "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time",
                       rating : 7.8,
                       duration :  "2h 30 min",
                       genre : "Action, Sci-Fi",
                       releasedDate :  "3 September 2020",
                       trailerLink : "https://www.youtube.com/watch?v=LdOM0x0XDMo"
                      )
                ]
        )
    }

}

// MARK: - Mock Classes
final class MockListViewController: MovieListViewControllerProtocol {
    
    var isCalledReloadData = false
    var isCalledShowLoading = false
    var isCalledHideLoading = false
    var isCalledSetupTableView = false
    var isCalledSetupView = false
    
    func reloadData() {
        isCalledReloadData = true
    }
    
    func showLoadingView() {
        isCalledShowLoading = true
    }
    
    func hideLoadingView() {
        isCalledHideLoading = true
    }
    
    func setupTableView() {
        isCalledSetupTableView = true
    }
    
    func setUpView() {
        isCalledSetupView = true
    }
}

final class MockListInteractor: MovieListInteractorProtocol {
    func sortMoviesList(sortType: SortType, movies: [MovieList]) {
    
    }
    
    var isFetchMoviesCalled = false
    
    func fetchMoviesList() {
        isFetchMoviesCalled = true
    }
    
}

final class MockListRouter: MovieListRouterProtocol {
    
    var isRouteDetail = false
    
    func navigate(_ route: MovieListRoutes) {
        isRouteDetail = true
    }
}
