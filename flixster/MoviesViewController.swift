//
//  MoviesViewController.swift
//  flixster
//
//  Created by Bhumi Patel on 2/17/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //creating an outlet for tabelView
    @IBOutlet weak var tabelView: UITableView!
    
    //creating an array of dictionaries, to be able to fetch the movies and add to
    
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabelView.dataSource = self
        tabelView.delegate = self
        
        print("Hello\n")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
            
            //casting as dictionaires...
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            //reloads and call the tabelView functions after the movies dictionary is downloaded using API.
            self.tabelView.reloadData()
              
            print(dataDictionary)
           
           
           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        
        let title = movie["title"] as! String //whats the type
        let synopsis = movie["overview"] as! String
        
        //getting the baseUrl and posterPath for movies
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        //third-party feature for downloading and setting images using AlamofireImage
        
        cell.posterView.af_setImage(withURL: posterUrl)
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        
        
        return cell
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
