//
//  MovieDetailsViewController.swift
//  MovieListApp
//
//  Created by Jyoti on 04/11/2022.
//

import UIKit

protocol MovieDetailsViewControllerProtocol: AnyObject {
    func reloadData()
    func setupTableView()
    func setUpView()
}

class MovieDetailsViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    var movieId: Int?
    var presenter: MovieDetailsViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
}

// MARK: - TabeView (ListDetails)
extension MovieDetailsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : MovieDetailsHeaderView = MovieDetailsHeaderView.fromNib()
        guard let movieObj = self.presenter.movieDetail else {
            return nil
        }
        view.viewPresenter = MovieDetailsHeaderPresenter(view: view, movie: movieObj)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}


// MARK: - Extension + MovieDetailsViewControllerProtocol
extension MovieDetailsViewController : MovieDetailsViewControllerProtocol {
    func reloadData() {
        
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.register(viewType: MovieDetailsHeaderView.self)
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0
        }
    }
    
    func setUpView() {
        setAccessibilityIdentifiers()
    }
}

// MARK: - Extension + setAccessibilityIdentifiers
extension MovieDetailsViewController {
    func setAccessibilityIdentifiers() {
        self.tableView.accessibilityIdentifier = "detailTableView"
    }
}
