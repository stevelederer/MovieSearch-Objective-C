//
//  MovieDetailViewController.swift
//  MovieSearch_Assessment_ObjC
//
//  Created by Steve Lederer on 12/21/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var movie: SHLMovie? {
        didSet {
            getImage()
        }
    }
    
    var posterPhoto: UIImage?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Setup
    
    func getImage() {
        guard let movie = movie else { return }
        SHLMovieController.fetchPosterImage(for: movie) { (image) in
            if let image = image {
                self.posterPhoto = image
            } else {
                self.posterPhoto = UIImage(named: "none")
            }
        }
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let movie = movie else { return }
        let ratingAsDouble = Double(truncating: movie.voteAverage)
        let rating = Double(round(100*ratingAsDouble)/100)
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(rating)"
        posterImageView.image = posterPhoto
        overviewTextView.text = movie.overview
    }
}
