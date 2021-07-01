//
//  ViewController.swift
//  Web Consuming
//
//  Created by Hojin Ryu on 01/07/21.
//

import UIKit

struct Movie {
    let title: String
    let voteAverage: Double
    let overview: String
    let genreIds: [Int]
    let posterPath: String
}

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2f8e29176bab443251fb4a3303db7498&language=en-US&page=1")!
        
        typealias WebMovies = [String: Any]
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                  let dictionary = json as? [String: Any],
                  let movies = dictionary["results"] as? [WebMovies]
            
            else { return }
            
            
            var localMoviesArray: [Movie] = []
            
            for movieDictionary in movies {
                guard let title = movieDictionary["title"] as? String,
                      let voteAverage = movieDictionary["vote_average"] as? Double,
                      let overview = movieDictionary["overview"] as? String,
                      let genreIds = movieDictionary["genre_ids"] as? [Int],
                      let posterPath = movieDictionary["poster_path"] as? String
                
                else { return }
                
                let movie = Movie(title: title, voteAverage: voteAverage, overview: overview, genreIds: genreIds, posterPath: posterPath)
                
                localMoviesArray.append(movie)
            }
            
            self.movies = localMoviesArray
            
            print(self.movies)
            
        }
        .resume()
    }


}

