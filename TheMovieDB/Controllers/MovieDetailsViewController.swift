//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by User on 21/02/21.
//

import UIKit

class MovieDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var crewCollectionView: UICollectionView!
    @IBOutlet weak var similarMoviesCollectionView: UICollectionView!
    var movieId = Int()
    var navMovieTitle = String()
    var movieCastingArray = [AnyObject]()
    var movieCrewArray = [AnyObject]()
    var similarMoviesArray = [AnyObject]()
    let services = TMDServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = navMovieTitle
        self.castCollectionView.register(UINib(nibName: "MovieCastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCastCollectionViewCell")
        self.crewCollectionView.register(UINib(nibName: "MovieCrewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCrewCollectionViewCell")
        self.similarMoviesCollectionView.register(UINib(nibName: "SimilarMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarMoviesCollectionViewCell")
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        crewCollectionView.delegate = self
        crewCollectionView.dataSource = self
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.dataSource = self
        getMovieDetails(id: movieId)
        getMovieCredits(id: movieId)
        getSimilarMovies(id: movieId)
        // Do any additional setup after loading the view.
    }
    
    func getMovieDetails(id:Int){
        services.getMovieDetails(id: id) { (response, error) in
            print(response as Any)
            let movieDetailsObject = TMDMovieDetailstModel()
            movieDetailsObject.parseMovieDetailsData(movieDetailsObject: response!)
            let movieImageLink = imageSrc + movieDetailsObject.imageUrl
            DispatchQueue.main.async {
                self.movieImage.imageFromURL(urlString: movieImageLink)
                self.movieTitle.text = movieDetailsObject.movieTitle
                self.movieReleaseDate.text = "Release Date: " + movieDetailsObject.movieReleaseDate
                self.movieLanguage.text = "Language: " + movieDetailsObject.movieLanguage
                self.movieGenre.text = "Genre: " + movieDetailsObject.movieGenre
                self.movieDescription.text = movieDetailsObject.movieDescription
            }
        }
    }
    
    func getMovieCredits(id:Int){
        services.getMovieCredits(id: id) { (response, error) in
            print(response as Any)
            DispatchQueue.main.async {
                self.movieCastingArray = response?["cast"] as? [AnyObject] ?? []
                self.movieCrewArray = response?["crew"] as? [AnyObject] ?? []
                print(self.movieCastingArray)
                self.castCollectionView.reloadData()
                self.crewCollectionView.reloadData()
            }
        }
    }
    
    func getSimilarMovies(id:Int){
        services.getSimilarMovies(id: id) { (response, error) in
            print(response as Any)
            DispatchQueue.main.async {
                self.similarMoviesArray = response?["results"] as? [AnyObject] ?? []
                self.similarMoviesCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView  == castCollectionView){
        return movieCastingArray.count
        }else if(collectionView  == crewCollectionView){
            return movieCrewArray.count
        }else{
            return similarMoviesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView  == castCollectionView){
        let cell : MovieCastCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCollectionViewCell", for: indexPath) as! MovieCastCollectionViewCell
        let movieObject = TMDMovieDetailstModel()
        movieObject.parseDataForMovieCast(movieCastObject:movieCastingArray[indexPath.row] as! NSDictionary)
        cell.loadData(data: movieObject)
        cell.layoutIfNeeded()
        return cell

        }else if (collectionView  == crewCollectionView) {
            let cell : MovieCrewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCrewCollectionViewCell", for: indexPath) as! MovieCrewCollectionViewCell
            let movieObject = TMDMovieDetailstModel()
            movieObject.parseDataForMovieCrew(movieCrewObject:movieCrewArray[indexPath.row] as! NSDictionary)
            cell.loadData(data: movieObject)
            cell.layoutIfNeeded()
            return cell
        }else{
            let cell : SimilarMoviesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMoviesCollectionViewCell", for: indexPath) as! SimilarMoviesCollectionViewCell
            let movieObject = TMDMovieDetailstModel()
            movieObject.parseDataForSimilarMovies(similarMovieObject:similarMoviesArray[indexPath.row] as! NSDictionary)
            cell.loadData(data: movieObject)
            cell.layoutIfNeeded()
            return cell
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
