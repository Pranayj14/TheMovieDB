//
//  MovieCrewCollectionViewCell.swift
//  TheMovieDB
//
//  Created by User on 22/02/21.
//

import UIKit

class MovieCrewCollectionViewCell: UICollectionViewCell {
   
  
    @IBOutlet weak var movieCrewImage: UIImageView!
    @IBOutlet weak var movieCrewName: UILabel!
    
    func loadData(data: TMDMovieDetailstModel){
        let movieCastProfileLink = imageSrc + data.crewImage
        movieCrewImage.imageFromURL(urlString: movieCastProfileLink)
        movieCrewName.text = data.crewName
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
        movieCrewImage.layer.cornerRadius = movieCrewImage.frame.height/2
        movieCrewImage.layer.masksToBounds = true
    }
}
