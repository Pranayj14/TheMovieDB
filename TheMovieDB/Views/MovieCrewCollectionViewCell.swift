//
//  MovieCrewCollectionViewCell.swift
//  TheMovieDB
//
//  Created by User on 22/02/21.
//

import UIKit

class MovieCrewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Declarations for outlets and variables.
    @IBOutlet weak var movieCrewImage: UIImageView!
    @IBOutlet weak var movieCrewName: UILabel!
    
    // MARK: - Load Data to load MovieCrewCollectionViewCell.
    func loadData(data: TMDMovieDetailstModel){
        let movieCastProfileLink = imageSrc + data.crewImage
        movieCrewImage.imageFromURL(urlString: movieCastProfileLink)
        movieCrewName.text = data.crewName
    }
    
    // MARK: - Layout subview to provide corner radius to image view.
    override func layoutSubviews() {
        super.layoutSubviews()
        movieCrewImage.layer.cornerRadius = movieCrewImage.frame.height/2
        movieCrewImage.layer.masksToBounds = true
    }
}
