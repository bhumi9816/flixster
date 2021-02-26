//
//  MovieGridViewController.swift
//  flixster
//
//  Created by Bhumi Patel on 2/22/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //creating layout to configure collection view cells
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        //how do we configure??
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 2
        layout.itemSize = CGSize(width: width, height: width * 3/2)

        //TODO: get all the superhero movies
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              self.movies = dataDictionary["results"] as! [[String:Any]]
            
              //print(dataDictionary)
             
              self.collectionView.reloadData()
           
           }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        //collections view fetch the movie item
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.posterView.af_setImage(withURL: posterUrl)
        
        
        return cell
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //print("Loading up the superhero movie details\n")
        
        //find the selected superHero movie
        let cell = sender as! UICollectionViewCell //casting the send as collectionView cell
        
        //getting the indexPath
        let indexPath = collectionView.indexPath(for: cell)!
        
        //getting the movie for that specific indexPath
        let movie = movies[indexPath.row]
        
        //pass the movie to the superHero screen and set it as destination
        let superherodetail = segue.destination as! SuperheroDetailViewController
        
        //setting that movie to this screen
        superherodetail.movie = movie
        
        //pass the selected movie to details
    }


}
