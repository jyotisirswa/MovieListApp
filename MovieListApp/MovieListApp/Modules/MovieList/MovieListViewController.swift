//
//  MovieListViewController.swift
//  MovieListApp
//
//  Created by Jyoti on 04/11/2022.
//

import UIKit

protocol MovieListViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupTableView()
    func setUpView()
}

final class MovieListViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: MovieListPresenterProtocol!
    @IBOutlet private weak var tableView: UITableView!

    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieListRouter.createModule(movieListVCRef: self)
        presenter.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveReloadNotification(notification:)), name:  Notification.Name("RELOAD_NOTIFICATION"), object: nil)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode =  .always
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        //navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Functions + IBActions
    @objc func didReceiveReloadNotification(notification: NSNotification) {
        if let dict = notification.object as? [String : Any], let movie = dict["movie"] as? MovieList {
            self.presenter?.refreshData(movieObj: movie)
        }
    }
    
    @IBAction private func onSortButtonTapped(_ sender: UIBarButtonItem) {
        presenter.showActionSheet()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - Extension +  MovieListViewControllerProtocol
extension MovieListViewController : MovieListViewControllerProtocol {
    func reloadData() {
        tableView.reloadSections(IndexSet.init(arrayLiteral: 0), with: .fade)
    }
    
    func showLoadingView() {
    }
    
    func hideLoadingView() {
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: MovieListTableCell.self)
    }
    
    func setUpView() {
        setAccessibilityIdentifiers()
    }
}

// MARK: - TabeView (List)
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MovieListTableCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let movie = presenter.movie(indexPath.row) {
            cell.cellPresenter = MovieListCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

//MARK: - Extension +  SettingAccessibilityIdentifiers
extension MovieListViewController {
    func setAccessibilityIdentifiers() {
        tableView.accessibilityIdentifier = "listTableView"
    }
}
