//
//  SimilarMoviesCollectionViewCell.swift
//  TheMovieDB
//
//  Created by User on 22/02/21.
//

import UIKit

class SimilarMoviesCollectionViewCell: UICollectionViewCell {
    // MARK: - Declarations for outlets and variables.
    @IBOutlet weak var similarMovieImage: UIImageView!
    @IBOutlet weak var similarMovieName: UILabel!
    
    // MARK: - Load Data to load SimilarMoviesCollectionViewCell.
    func loadData(data: TMDMovieDetailstModel){
        let movieCastProfileLink = imageSrc + data.imageUrl
        similarMovieImage.imageFromURL(urlString: movieCastProfileLink)
        similarMovieName.text = data.movieTitle
    }
    
    // MARK: - Layout subview to provide corner radius to image view.
    override func layoutSubviews() {
        super.layoutSubviews()
        similarMovieImage.layer.cornerRadius = similarMovieImage.frame.height/2
        similarMovieImage.layer.masksToBounds = true
    }
}
