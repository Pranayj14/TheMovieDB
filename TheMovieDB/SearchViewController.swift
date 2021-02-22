//
//  SearchViewController.swift
//  TheMovieDB
//
//  Created by User on 21/02/21.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var recentlySearchedLabel: UILabel!
    @IBOutlet weak var movieSearchTextfield: UITextField!
    @IBOutlet weak var searchMovieListTableView: UITableView!
    var searchTimer: Timer?
    let movieObject = TMDMovieListModel()
    let userDefaults = UserDefaults.standard
    let services = TMDServices()
    var totalPages = Int()
    var recentlySearchedArray = [AnyObject]()
    var recentlySearchedDict = NSMutableDictionary()
    var movieList = [AnyObject]()
    var searchedMovieList = [AnyObject]()
    var pageNo = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        searchMovieListTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        self.movieSearchTextfield.delegate = self
        self.searchMovieListTableView.delegate = self
        self.searchMovieListTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.object(forKey: "recentlySearchedArray") as? [AnyObject] != nil && movieSearchTextfield.text?.count ?? 0 == 0{
            recentlySearchedArray = userDefaults.object(forKey: "recentlySearchedArray") as? [AnyObject] ?? []
            recentlySearchedLabel.isHidden = false
            self.searchMovieListTableView.isHidden = false
            DispatchQueue.main.async {
                self.searchMovieListTableView.reloadData()
            }
        }else{
            if(movieSearchTextfield.text?.count ?? 0 == 0){
                self.searchMovieListTableView.isHidden = true
                recentlySearchedLabel.isHidden = true
            }else{
                recentlySearchedLabel.isHidden = true
                self.searchMovieListTableView.isHidden = false
            }
            
        }
        
        getMovieList(pageNo: 1)
    }

    
    func getMovieList(pageNo:Int){
        services.getMovieList(pageNo: pageNo) { (response, error) in
//            print(self.pageNo)
            self.totalPages = response?["total_pages"] as? Int ?? 0
            
            if let movieList:[AnyObject] = response?["results"] as? [AnyObject] {
            self.movieList += movieList
//                print("self.movieList.count",self.movieList.count)
            }
            DispatchQueue.main.async {
            for _ in self.pageNo..<self.totalPages{
                self.pageNo = self.pageNo + 1
//                print("self.pageNo",self.pageNo)
                self.getMovieList(pageNo: self.pageNo)
            }
            
            }
        }
    }
    
    // MARK: - function todismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(recentlySearchedArray.count > 0 && movieSearchTextfield.text?.count ?? 0 == 0){
           return recentlySearchedArray.count
        }else{
            return searchedMovieList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        if(recentlySearchedArray.count > 0 && movieSearchTextfield.text?.count ?? 0 == 0){
            cell.movieName.text = recentlySearchedArray[indexPath.row]["title"] as? String ?? ""
        }else{
            movieObject.parseData(movieObject:searchedMovieList[indexPath.row] as! NSDictionary)
            cell.loadData(data: movieObject)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var addObjectBool = true
        if recentlySearchedArray.count == 5{
            recentlySearchedArray.removeFirst()
        }
        if(recentlySearchedArray.count >= 1){
        for i in 0...recentlySearchedArray.count - 1{
            if(searchedMovieList.count >= 1){
                if(searchedMovieList[indexPath.row]["title"] as? String ?? "" == recentlySearchedArray[i]["title"] as? String ?? ""){
                addObjectBool = false
            }
            }
        }
        }
        if(searchedMovieList.count == 0){
             addObjectBool = false
        }
        
        if(addObjectBool){
            recentlySearchedDict.setValue(searchedMovieList[indexPath.row]["title"] as? String ?? "", forKey: "title")
            recentlySearchedDict.setValue(searchedMovieList[indexPath.row]["id"] as? Int ?? 0, forKey: "id")
        recentlySearchedArray.append(recentlySearchedDict)
            print(recentlySearchedArray)
        userDefaults.setValue(recentlySearchedArray, forKey: "recentlySearchedArray")
        }
        if(searchedMovieList.count >= 1){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        vc.movieId = searchedMovieList[indexPath.row]["id"] as? Int ?? 0
        vc.navMovieTitle = searchedMovieList[indexPath.row]["title"] as? String ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
            vc.movieId = recentlySearchedArray[indexPath.row]["id"] as? Int ?? 0
            vc.navMovieTitle = recentlySearchedArray[indexPath.row]["title"] as? String ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func searchMovieText(_ sender: Any) {
        recentlySearchedLabel.isHidden = true
        self.searchMovieListTableView.isHidden = false
        searchedMovieList.removeAll()
        if(movieSearchTextfield.text?.count ?? 0 >= 1){
            for i in 0...movieList.count - 1{
                let movieTitle = movieList[i]["title"] as? String ?? ""
                let movieTitleArray = movieTitle.components(separatedBy: " ")
//                print(movieTitleArray)
                for j in 0...movieTitleArray.count - 1{
                    let word = movieTitleArray[j]
                    let namex = word.prefix(movieSearchTextfield.text?.count ?? 0)
                    if namex == movieSearchTextfield.text?.capitalized ?? ""{
                        searchedMovieList.append(movieList[i])
                        print(searchedMovieList)
                        
                    }
                    break
                }
            }
        }else{
            if(recentlySearchedArray.count < 0){
            recentlySearchedLabel.isHidden = false
            }
            searchedMovieList.removeAll()
            self.searchMovieListTableView.reloadData()
            if(recentlySearchedArray.count == 0){
                self.searchMovieListTableView.isHidden = true
            }
            
        }
        DispatchQueue.main.async {
            self.searchMovieListTableView.reloadData()
        }
    }
    
    @IBAction func clearSearchText(_ sender: Any) {
        movieSearchTextfield.text = ""
        movieSearchTextfield.placeholder = "Search Users"
        searchedMovieList.removeAll()
        if(recentlySearchedArray.count > 0){
        recentlySearchedLabel.isHidden = false
        }
        if(recentlySearchedArray.count == 0){
            self.searchMovieListTableView.isHidden = true
            recentlySearchedLabel.isHidden = true
        }
        self.searchMovieListTableView.reloadData()
        movieSearchTextfield.resignFirstResponder()
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
