//
//  ViewController.swift
//  TheMovieDB
//
//  Created by User on 20/02/21.
//

import UIKit

@available(iOS 13.0, *)
class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Declarations for outlets and variables.
    var movieList = [AnyObject]()
    var pageNo = 1
    var totalCount = Int()
    var lastSectionIndex = Int()
    var loadMore = false
    let spinner = UIActivityIndicatorView(style: .medium)
    let services = TMDServices()
    let movieListModel = TMDMovieListModel()
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var movieListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Movie List"
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(goToSearch)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = searchButton
        movieListTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        if #available(iOS 10.0, *) {
            movieListTableView.refreshControl = refreshControl
        } else {
            movieListTableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Stay Tuned...")
        refreshControl.addTarget(self, action: #selector(refreshMovieList(_:)), for: .valueChanged)
        getMovieList(pageNo: pageNo)
    }
    
    // MARK: - this function gets called when pressed on search icon on the navigation bar.
    @objc func goToSearch(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - This function refreshes the movies list and loads page number 1.
    @objc func refreshMovieList(_ sender: Any) {
        getMovieList(pageNo: 1)
    }
    
    // MARK: - GetMovieList to get movie list data.
    func getMovieList(pageNo:Int){
        services.getMovieList(pageNo: pageNo) { (response, error) in
            if(error == nil){
                self.totalCount = response?["total_results"] as? Int ?? 0
                if let movieList:[AnyObject] = response?["results"] as? [AnyObject] {
                    self.movieList += movieList
                }
                DispatchQueue.main.async {
                    self.movieListTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: "Check your internet connection or contact the Administrator.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                        self.getMovieList(pageNo:pageNo)
                    }))
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
    }
    
    // MARK: - Displays numberOfRowsInSection according to array count in tableview.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    // MARK: - Loads tableview cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        let movieObject = TMDMovieListModel()
        movieObject.parseData(movieObject:movieList[indexPath.row] as! NSDictionary)
        cell.loadData(data: movieObject)
        return cell
    }
    
    // MARK: - Selects a particular cell in tableview or navigates to particular controller on cell selection.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        vc.movieId = movieList[indexPath.row]["id"] as? Int ?? 0
        vc.navMovieTitle = movieList[indexPath.row]["title"] as? String ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - This function is used for implementation of pagination.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
        lastSectionIndex = movieListTableView.numberOfSections - 1
        //        let lastRowIndex = movieListTableView.numberOfRows(inSection: lastSectionIndex) - 1
        if movieListModel.loadMore(lastRowIndex: movieListTableView.numberOfRows(inSection: lastSectionIndex) - 1, currentRow: indexPath.row, totalCount: totalCount, userCount: movieList.count, loadMore: loadMore){
            spinner.isHidden = false
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: movieListTableView.bounds.width, height: CGFloat(44))
            self.movieListTableView.tableFooterView = spinner
            
            self.movieListTableView.tableFooterView?.isHidden = false
            loadMore = true
            pageNo = pageNo + 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.getMovieList(pageNo: self.pageNo)
                self.loadMore = false
            }
        }
        
    }
}
