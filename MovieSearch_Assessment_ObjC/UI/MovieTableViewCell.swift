//
//  MovieTableViewCell.swift
//  MovieSearch_Assessment_ObjC
//
//  Created by Steve Lederer on 12/21/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    // MARK: - Dependency
    
    var movie: SHLMovie? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCells()
    }
    
    // MARK: - Setup
    
    func updateViews() {
        guard let movie = movie else { return }
        let ratingAsDouble = Double(truncating: movie.voteAverage)
        let rating = Double(round(100*ratingAsDouble)/100)
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.ratingLabel.text = "Rating: \(rating)"
            self.overviewLabel.text = movie.overview
        }
        SHLMovieController.fetchPosterImage(for: movie) { (image) in
            DispatchQueue.main.async {
                if let image = image {
                    self.posterImageView.image = image
                } else {
                    self.posterImageView.image = UIImage(named: "none")
                }
            }
        }
    }
    
    func setupCells() {
        self.backgroundColor = .clear
        cellView.layer.cornerRadius = 15
        cellView.layer.shadowOpacity = 0.4
        cellView.layer.shadowColor = UIColor.darkGray.cgColor
        cellView.layer.shadowRadius = 7
        cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        posterImageView.clipsToBounds = true
        self.posterImageView.layer.cornerRadius = 10
    }
}
