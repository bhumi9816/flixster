//
//  SuperheroDetailViewController.swift
//  flixster
//
//  Created by Bhumi Patel on 2/24/21.
//

import UIKit
import AlamofireImage

class SuperheroDetailViewController: UIViewController {
    
    @IBOutlet weak var backDropImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var movie: [String:Any]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Debug: statements print("in the superHero detail controller\n")
        //print(movie["title"])
        
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        dateLabel.text = movie["release_date"] as? String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        posterImage.af_setImage(withURL: posterUrl)
        
        
        let backdropPath = movie["backdrop_path"] as! String
        
        let backdropUrl = URL(string:"https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backDropImage.af_setImage(withURL: backdropUrl!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/

}
