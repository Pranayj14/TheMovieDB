//
//  SearchTableViewCell.swift
//  TheMovieDB
//
//  Created by User on 21/02/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadData(data: TMDMovieListModel){
        movieName.text = data.movieTitle
    }
}
