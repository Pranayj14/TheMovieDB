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
    // MARK: - GetMovieList api call.
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
                    completionHandler(json, nil)
                    
                }catch _ as NSError {
                    completionHandler(nil, error!)
                }
                
            }else{
                completionHandler(nil, error!)
            }
            
        }.resume()
    }
    
    // MARK: - GetMovieDetails api call.
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
                    completionHandler(json, nil)
                    
                }catch _ as NSError {
                    completionHandler(nil, error!)
                }
                
            }else{
                completionHandler(nil, error!)
            }
            
        }.resume()
    }
    
    // MARK: - GetMovieCredits api call.
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
                    completionHandler(json, nil)
                    
                }catch _ as NSError {
                    completionHandler(nil, error!)
                }
                
            }else{
                completionHandler(nil, error!)
            }
            
        }.resume()
    }
    
    // MARK: - GetSimilarMovies api call.
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
                    completionHandler(json, nil)
                }catch _ as NSError {
                    completionHandler(nil, error!)
                }
                
            }else{
                completionHandler(nil, error!)
            }
            
        }.resume()
    }
    
}
