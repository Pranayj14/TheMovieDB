//
//  SimilarMoviesCollectionViewCell.swift
//  TheMovieDB
//
//  Created by User on 22/02/21.
//

import UIKit

class SimilarMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var similarMovieImage: UIImageView!
    @IBOutlet weak var similarMovieName: UILabel!
    
    func loadData(data: TMDMovieDetailstModel){
        let movieCastProfileLink = imageSrc + data.imageUrl
        similarMovieImage.imageFromURL(urlString: movieCastProfileLink)
        similarMovieName.text = data.movieTitle
    }
}
