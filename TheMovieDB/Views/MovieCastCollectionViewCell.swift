//
//  CastCollectionViewCell.swift
//  TheMovieDB
//
//  Created by User on 22/02/21.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieCastImage: UIImageView!
    @IBOutlet weak var movieCastName: UILabel!
    
    func loadData(data: TMDMovieDetailstModel){
        let movieCastProfileLink = imageSrc + data.castImage
        movieCastImage.imageFromURL(urlString: movieCastProfileLink)
        movieCastName.text = data.castName
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
        movieCastImage.layer.cornerRadius = movieCastImage.frame.height/2
        movieCastImage.layer.masksToBounds = true
    }
    
}
