//
//  ViewController.swift
//  Web Consuming
//
//  Created by Hojin Ryu on 01/07/21.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    let moviesAPI = MovieAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        moviesAPI.getPopularMovie(page: 1, completionHandler: { movies in
            self.movies = movies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        moviesAPI.getNowPlayingMovie(page: 1, completionHandler: { movies in
            self.movies = movies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "moviesList", for: indexPath) as? MoviesListTableViewCell else {
            fatalError("Não foi possivel converter a celula para MovieCell")
        }
        

        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.voteAverageLabel.text = String(movie.voteAverage)
        cell.posterImage.image = movie.posterImage
        
        return cell
    }


}

