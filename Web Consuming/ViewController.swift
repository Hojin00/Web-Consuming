//
//  ViewController.swift
//  Web Consuming
//
//  Created by Hojin Ryu on 01/07/21.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var PopularMovies: [Movie] = []
    var NowPlayingMovies: [Movie] = []
    let moviesAPI = MovieAPI()
    var movieSection: [[String: [Movie]]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        moviesAPI.getPopularMovie(page: 1, completionHandler: { movies in
            self.movieSection[0]["Popular"] = movies
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        moviesAPI.getNowPlayingMovie(page: 1, completionHandler: { movies in
            self.movieSection[1]["Now Playing"] = movies

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        
        movieSection = [["Popular": PopularMovies], ["Now Playing": NowPlayingMovies]]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieSection.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2
        } else if section == 1{
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Popular"
        } else if section == 1{
            return "Now Playing"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "descri", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="descri", let indexPath = sender as? IndexPath {
            
            
        }
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "moviesList", for: indexPath) as? MoviesListTableViewCell else {
            fatalError("Não foi possivel converter a celula para MovieCell")
        }
        
        if indexPath.section == 0 {
            guard let movies = movieSection[indexPath.section]["Popular"] else { fatalError() }
            
            
            let moviesPop = movies[indexPath.row]
            
            guard let imagePop = moviesAPI.getMoviePoster(with: URL(string: "https://image.tmdb.org/t/p/w500/\(moviesPop.posterPath)")) else { fatalError() }
            
            cell.titleLabel.text = moviesPop.title
            cell.overviewLabel.text = moviesPop.overview
            cell.voteAverageLabel.text = String(moviesPop.voteAverage)
            cell.posterImage.image = imagePop
            
        } else if indexPath.section == 1 {
            guard let movies = movieSection[indexPath.section]["Now Playing"] else { fatalError() }
            let moviesNow = movies[indexPath.row]
            
            guard let imageNow = moviesAPI.getMoviePoster(with: URL(string: "https://image.tmdb.org/t/p/w500/\(moviesNow.posterPath)")) else { fatalError() }
            
            cell.titleLabel.text = moviesNow.title
            cell.overviewLabel.text = moviesNow.overview
            cell.voteAverageLabel.text = String(moviesNow.voteAverage)
            cell.posterImage.image = imageNow
        }
        
        
        return cell
    }


}

