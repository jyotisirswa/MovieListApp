//
//  MovieListTableCell.swift
//  MovieListApp
//
//  Created by Jyoti on 04/11/2022.
//

import UIKit


protocol MovieListCellProtocol: AnyObject {
    func setMovieImage(_ image : UIImage)
    func setWatchListButton(_ isWatchListAdded: Bool)
    func setDurationNGenreLabel(_ text: String)
    func setTitleLabel(_ text: String)
    func setAccessibilityIdentifiers()
}

final class MovieListTableCell: UITableViewCell {
    
    @IBOutlet private weak var movieImage: SwiftShadowImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var timeNGenreLabel: UILabel!
    @IBOutlet private weak var onMyWatchList: UILabel!

    var cellPresenter: MovieListCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MovieListTableCell : MovieListCellProtocol {
    func setTitleLabel(_ text: String) {
        titleLabel.text = text
        titleLabel.layoutIfNeeded()
    }
    
    func setMovieImage(_ image: UIImage) {
        movieImage.image = image
    }
    
    func setWatchListButton(_ isWatchListAdded: Bool) {
        self.onMyWatchList.isHidden = !isWatchListAdded
    }
    
    func setDurationNGenreLabel(_ text: String) {
        timeNGenreLabel.text = text
    }
}

extension MovieListTableCell {
    func setAccessibilityIdentifiers() {
        movieImage.accessibilityIdentifier = "listCellMovieImage"
        titleLabel.accessibilityIdentifier = "titleLabel"
        timeNGenreLabel.accessibilityIdentifier = "timeNGenreLabel"
        onMyWatchList.accessibilityIdentifier = "onMyWatchList"
    }
}
