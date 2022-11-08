//
//  MovieDetailsHeaderView.swift
//  MovieListApp
//
//  Created by Jyoti on 08/11/2022.
//

import UIKit

protocol MovieDetailsHeaderViewProtocol: AnyObject {
    func setMovieImage(_ image : UIImage)
    func setTitleLabelNRating(_ titleLabel: String, ratings : Double)
    func setWatchListButton(_ title: String)
    func setDescription(_ description : String)
    func setGenreNDurationLabel(_ genre: String, releaseDate : String)
    func setAccessibilityIdentifiers()
}


class MovieDetailsHeaderView: UITableViewHeaderFooterView {
    //MARK: - Properties
    @IBOutlet private weak var movieImage: SwiftShadowImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel! {
        didSet {
            ratingLabel.changeColor()
        }
    }
    @IBOutlet private weak var buttonWatchList: UIButton! {
        didSet {
            buttonWatchList.titleLabel?.numberOfLines = 1
            buttonWatchList.applyBorderNColor(borderColor: .clear)
        }
    }
    @IBOutlet private weak var buttonWatchTrailer: UIButton! {
        didSet {
            buttonWatchTrailer.applyBorderNColor()
        }
    }
   @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!

    var viewPresenter: MovieDetailsHeaderPresenterProtocol! {
        didSet {
            viewPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func didTapAddWatchList(_ sender: Any) {
        viewPresenter.addWatchListButtonTapped()
    }
    
    @IBAction func didTapWatchTrailer(_ sender: Any) {
        viewPresenter.openYoutubeURL()
    }
}
//MARK: - Extension +  MovieDetailsHeaderViewProtocol
extension MovieDetailsHeaderView : MovieDetailsHeaderViewProtocol {
    func setMovieImage(_ image: UIImage) {
        movieImage.image = image
    }
    
    func setTitleLabelNRating(_ titleLabel: String, ratings: Double) {
        self.titleLabel.text = titleLabel
        ratingLabel.text = "\(ratings)/10"
        ratingLabel.changeColor()
    }
    
    func setWatchListButton(_ title: String) {
        buttonWatchList.setTitle(title, for: .normal)
    }
    
    func setDescription(_ description: String) {
        descriptionLabel.text = description
    }
    
    func setGenreNDurationLabel(_ genre: String, releaseDate: String) {
        genreLabel.text = genre
        durationLabel.text = releaseDate
    }
}
//MARK: - Extension +  setAccessibilityIdentifiers
extension MovieDetailsHeaderView {
    func setAccessibilityIdentifiers() {
        movieImage.accessibilityIdentifier = "headerViewMovieImage"
        titleLabel.accessibilityIdentifier = "headerViewTitleLabel"
        ratingLabel.accessibilityIdentifier = "headerViewRatingLabel"
        buttonWatchList.accessibilityIdentifier = "buttonWatchList"
        buttonWatchTrailer.accessibilityIdentifier = "buttonWatchTrailer"
        descriptionLabel.accessibilityIdentifier = "headerViewDescriptionLabel"
        genreLabel.accessibilityIdentifier = "headerViewGenreLabel"
        durationLabel.accessibilityIdentifier = "headerViewDurationLabel"
    }
}


