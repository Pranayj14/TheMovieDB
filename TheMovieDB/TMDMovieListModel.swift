//
//  TMDMovieListModel.swift
//  TheMovieDB
//
//  Created by User on 20/02/21.
//

import Foundation

class TMDMovieListModel: NSObject {
    var movieTitle = String()
    var movieReleaseDate = String()
    var movieDescription = String()
    var imageUrl = String()
    func parseData(movieObject:NSDictionary){
        movieTitle = movieObject["title"] as? String ?? ""
        movieReleaseDate = movieObject["release_date"] as? String ?? ""
        movieDescription = movieObject["overview"] as? String ?? ""
        imageUrl = movieObject["poster_path"] as? String ?? ""
    }
    func loadMore(lastRowIndex: Int, currentRow: Int, totalCount: Int, userCount: Int, loadMore: Bool) -> Bool{
        
            if currentRow == lastRowIndex {
                if totalCount > userCount && !loadMore && userCount > 0{
                    return true
                }
            }
        return false
    }
}
