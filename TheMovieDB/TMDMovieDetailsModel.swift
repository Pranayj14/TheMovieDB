//
//  TMDMovieDetailsModel.swift
//  TheMovieDB
//
//  Created by User on 22/02/21.
//

import Foundation

class TMDMovieDetailstModel: NSObject {
    var imageUrl = String()
    var movieTitle = String()
    var movieReleaseDate = String()
    var movieLanguage = String()
    var movieGenre = String()
    var movieDescription = String()
    var languageString = String()
    var castName = String()
    var castImage = String()
    var crewName = String()
    var crewImage = String()
    func parseMovieDetailsData(movieDetailsObject:NSDictionary){
        print(movieDetailsObject)
        imageUrl = movieDetailsObject["poster_path"] as? String ?? ""
        movieTitle = movieDetailsObject["title"] as? String ?? ""
        movieReleaseDate = movieDetailsObject["release_date"] as? String ?? ""
        let movieSpokenLanguage = movieDetailsObject["spoken_languages"] as? [AnyObject] ?? []
        let movieLanguageString:[String] = movieSpokenLanguage.map{$0["english_name"] as? String ?? ""}
        movieLanguage = appendString(concatArray: movieLanguageString)
        let moviegenres = movieDetailsObject["genres"] as? [AnyObject] ?? []
        let genres:[String] = moviegenres.map{$0["name"] as? String ?? ""}
        movieGenre = appendString(concatArray: genres)
        movieDescription = movieDetailsObject["overview"] as? String ?? ""
    }
    
    
    func parseDataForMovieCast(movieCastObject: NSDictionary){
        castName = movieCastObject["name"] as? String ?? ""
        castImage = movieCastObject["profile_path"] as? String ?? ""
    }
    
    func parseDataForMovieCrew(movieCrewObject: NSDictionary){
        crewName = movieCrewObject["name"] as? String ?? ""
        crewImage = movieCrewObject["profile_path"] as? String ?? ""
    }
    
    func parseDataForSimilarMovies(similarMovieObject: NSDictionary){
        movieTitle = similarMovieObject["title"] as? String ?? ""
        imageUrl = similarMovieObject["poster_path"] as? String ?? ""
    }
    
    
    
    func appendString(concatArray: [String]) -> String {
        self.languageString = ""
        if(concatArray.count >= 1){
        for i in 0...concatArray.count - 1{
            if(concatArray.count - 1 == i){
            self.languageString = languageString  + concatArray[i]
            }else{
                self.languageString = languageString  + concatArray[i] + ", "

            }
        }
        }
        print(languageString)
        return languageString
    }
}
