//
//  MovieListTableViewCell.swift
//  TheMovieDB
//
//  Created by User on 20/02/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    // MARK: - Declarations for outlets and variables.
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Load Data to load MovieListTableViewCell.
    func loadData(data: TMDMovieListModel){
        movieTitle.text = data.movieTitle
        releaseDate.text = data.movieReleaseDate
        movieDescription.text = data.movieDescription
        let movieImageLink = imageSrc + data.imageUrl
        movieImage.imageFromURL(urlString: movieImageLink)
    }
    
}
