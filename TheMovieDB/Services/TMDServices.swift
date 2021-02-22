//
//  TMDServices.swift
//  TheMovieDB
//
//  Created by User on 20/02/21.
//

import Foundation

class TMDServices {
    // MARK: - Declaration of variables.
    var json = NSDictionary()
    typealias response = NSDictionary
    typealias jsonHandler = (response?, Error?) -> Void
    func getMovieList(pageNo: Int, completionHandler: @escaping jsonHandler){
        let getURL : String = getMovieListApi + apiKey + "&" + "page=\(pageNo)"
        
        let url = URL(string : getURL)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if error == nil {
                
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    print("self.movieList",json as Any)
                    completionHandler(json, nil)
//                    DispatchQueue.main.async {
//                        completed()
//                    }
                    
                }catch _ as NSError {
                    completionHandler(nil, error!)
//                    DispatchQueue.main.async {
//                        let alert = UIAlertController(title: "", message: "Check your internet connection or contact the Administrator.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
////                            self.getAuthorList {
////                                self.authorsCollectionView.reloadData()
////
////                            }
//                        }))
//                        self.present(alert, animated: false, completion: nil)
//                    }
                    
                }
                
            }else{
                completionHandler(nil, error!)
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "", message: "Check your internet connection or contact the Administrator.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
////                        self.getAuthorList {
////                            self.authorsCollectionView.reloadData()
////
////                        }
//                    }))
//                    self.present(alert, animated: false, completion: nil)
//
//                }
                
            }
            
        }.resume()
    }

    func getMovieDetails(id:Int,completionHandler: @escaping jsonHandler){
        let getURL : String = getMovieDetailsApi + "\(id)?" + apiKey
        
        let url = URL(string : getURL)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if error == nil {
                
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    print("self.movieList",json as Any)
                    completionHandler(json, nil)
//                    DispatchQueue.main.async {
//                        completed()
//                    }
                    
                }catch _ as NSError {
                    completionHandler(nil, error!)
//                    DispatchQueue.main.async {
//                        let alert = UIAlertController(title: "", message: "Check your internet connection or contact the Administrator.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
////                            self.getAuthorList {
////                                self.authorsCollectionView.reloadData()
////
////                            }
//                        }))
//                        self.present(alert, animated: false, completion: nil)
//                    }
                    
                }
                
            }else{
                completionHandler(nil, error!)
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "", message: "Check your internet connection or contact the Administrator.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
////                        self.getAuthorList {
////                            self.authorsCollectionView.reloadData()
////
////                        }
//                    }))
//                    self.present(alert, animated: false, completion: nil)
//
//                }
                
            }
            
        }.resume()
    }
    
    
    func getMovieCredits(id:Int,completionHandler: @escaping jsonHandler){
        let getURL : String = getMovieDetailsApi + "\(id)/credits?" + apiKey
        
        let url = URL(string : getURL)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if error == nil {
                
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    print("self.movieList",json as Any)
                    completionHandler(json, nil)
//                    DispatchQueue.main.async {
//                        completed()
//                    }
                    
                }catch _ as NSError {
                    completionHandler(nil, error!)
//                    DispatchQueue.main.async {
//                        let alert = UIAlertController(title: "", message: "Check your internet connection or contact the Administrator.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
////                            self.getAuthorList {
////                                self.authorsCollectionView.reloadData()
////
////                            }
//                        }))
//                        self.present(alert, animated: false, completion: nil)
//                    }
                    
                }
                
            }else{
                completionHandler(nil, error!)
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "", message: "Check your internet connection or contact the Administrator.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
////                        self.getAuthorList {
////                            self.authorsCollectionView.reloadData()
////
////                        }
//                    }))
//                    self.present(alert, animated: false, completion: nil)
//
//                }
                
            }
            
        }.resume()
    }

    func getSimilarMovies(id:Int,completionHandler: @escaping jsonHandler){
        let getURL : String = getMovieDetailsApi + "\(id)/similar?" + apiKey
        
        let url = URL(string : getURL)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if error == nil {
                
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    print("self.movieList",json as Any)
                    completionHandler(json, nil)
//                    DispatchQueue.main.async {
//                        completed()
//                    }
                    
                }catch _ as NSError {
                    completionHandler(nil, error!)
//                    DispatchQueue.main.async {
//                        let alert = UIAlertController(title: "", message: "Check your internet connection or contact the Administrator.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
////                            self.getAuthorList {
////                                self.authorsCollectionView.reloadData()
////
////                            }
//                        }))
//                        self.present(alert, animated: false, completion: nil)
//                    }
                    
                }
                
            }else{
                completionHandler(nil, error!)
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "", message: "Check your internet connection or contact the Administrator.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
////                        self.getAuthorList {
////                            self.authorsCollectionView.reloadData()
////
////                        }
//                    }))
//                    self.present(alert, animated: false, completion: nil)
//
//                }
                
            }
            
        }.resume()
    }
    
}
