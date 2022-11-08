//
//  MovieListAppUITests.swift
//  MovieListAppUITests
//
//  Created by Jyoti on 04/11/2022.
//

import XCTest
@testable import MovieListApp


class MovieListAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("🚨****** UITest Began ******🚨")
    }
    
    func test_list_view_controller_elements_exist(){
        app.launch()
        //sleep(1)
        XCTAssertTrue(app.isListTableViewDisplayed)
        XCTAssertTrue(app.isListCellMovieImageDisplayed)
        XCTAssertTrue(app.isListCellTitleLabelDisplayed)
        XCTAssertTrue(app.isListCellTimeNGenreLabelDisplayed)
        XCTAssertTrue(app.isListCellonMyWatchListDisplayed)
    }
    
    func test_navigate_detail_view_controller_with_movie_cell(){
        app.launch()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIApplication {
    
    // MARK: - List View Controller
    var listTableView: XCUIElement! {
        tables["listTableView"]
    }
    
    var isListTableViewDisplayed: Bool {
        listTableView.exists
    }
    
    var listCellMovieImage: XCUIElement! {
        otherElements["listCellMovieImage"]
    }
    
    var isListCellMovieImageDisplayed: Bool {
        listCellMovieImage.exists
    }
    
    var titleLabel: XCUIElement! {
        staticTexts.matching(identifier: "titleLabel").element
    }
    
    var isListCellTitleLabelDisplayed: Bool {
        titleLabel.exists
    }
    
    var timeNGenreLabel: XCUIElement! {
        staticTexts.matching(identifier: "timeNGenreLabel").element
    }
    
    var isListCellTimeNGenreLabelDisplayed: Bool {
        timeNGenreLabel.exists
    }
    
    var onMyWatchList: XCUIElement! {
        staticTexts.matching(identifier: "onMyWatchList").element
    }
    
    var isListCellonMyWatchListDisplayed: Bool {
        onMyWatchList.exists
    }
    
    // MARK: - Detail View Controller
    var detailTableView: XCUIElement! {
        tables["detailTableView"]
    }
    
    var isdetailTableViewDisplayed: Bool {
        detailTableView.exists
    }
    
    var detailViewMovieImage: XCUIElement! {
        otherElements["headerViewMovieImage"]
    }
    
    var isDetailViewMovieImageDisplayed: Bool {
        detailViewMovieImage.exists
    }
    
    var detailViewTitleLabel: XCUIElement! {
        staticTexts.matching(identifier: "headerViewTitleLabel").element
    }
    
    var isDetailViewTitleLabelDisplayed: Bool {
        detailViewTitleLabel.exists
    }
    
    var ratingLabel: XCUIElement! {
        staticTexts.matching(identifier: "headerViewRatingLabel").element
    }
    
    var isDetailViewratingLabelDisplayed: Bool {
        ratingLabel.exists
    }
    
    var buttonWatchList: XCUIElement! {
        staticTexts.matching(identifier: "buttonWatchList").element
    }
    
    var isDetailViewButtonWatchListDisplayed: Bool {
        buttonWatchList.exists
    }
    
    var buttonWatchTrailer: XCUIElement! {
        staticTexts.matching(identifier: "buttonWatchTrailer").element
    }
    
    var isDetailViewButtonTrailertDisplayed: Bool {
        buttonWatchTrailer.exists
    }
    
    var descriptionLabel: XCUIElement! {
        staticTexts.matching(identifier: "descriptionLabel").element
    }
    
    var isDetailViewDescriptionDisplayed: Bool {
        descriptionLabel.exists
    }
    
    var genreLabel: XCUIElement! {
        staticTexts.matching(identifier: "genreLabel").element
    }
    
    var isDetailViewGenreDisplayed: Bool {
        genreLabel.exists
    }
    
    var durationLabel: XCUIElement! {
        staticTexts.matching(identifier: "durationLabel").element
    }
    
    var isDetailViewDurationDisplayed: Bool {
        durationLabel.exists
    }
}
