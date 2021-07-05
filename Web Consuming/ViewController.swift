
//  ViewController.swift
//  Web Consuming
//
//  Created by Hojin Ryu on 01/07/21.
//

import UIKit


struct MovieStruct {
    var title : String
    var description : String
    var genres : [Int]
    var rating : String
    var image : UIImage
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var PopularMovies: [Movie] = []
    var NowPlayingMovies: [Movie] = []
    let moviesAPI = MovieAPI()
    var genreTypesNames: [String]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        moviesAPI.getMovies(get: "popular", page: 1, completionHandler: { movies in
            self.PopularMovies = movies
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        moviesAPI.getMovies(get: "now_playing", page: 1, completionHandler: { movies in
            self.NowPlayingMovies = movies

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
//        for eachGenre in self.PopularMovies{
//            self.moviesAPI.getGenres(genres: eachGenre.genreIds) { genreType in
//                self.genreTypesNames = genreType
//            }
//
//            print("title: \(eachGenre.title), genreTypes: \(self.genreTypesNames)")
//        }
        
    
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return PopularMovies.count
        } else if section == 1{
            return NowPlayingMovies.count
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "moviesList", for: indexPath) as? MoviesListTableViewCell else {
            fatalError("Não foi possivel converter a celula para MovieCell")
        }
        
        if indexPath.section == 0 {
            
            let moviesPop = PopularMovies[indexPath.row]
           
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(moviesPop.posterPath)")
            
            cell.titleLabel.text = moviesPop.title
            cell.overviewLabel.text = moviesPop.overview
            cell.voteAverageLabel.text = String(moviesPop.voteAverage)
            cell.posterImage.load(url: url! )
            
        } else if indexPath.section == 1 {
            
            let moviesNow = NowPlayingMovies[indexPath.row]
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(moviesNow.posterPath)")
           
            
            cell.titleLabel.text = moviesNow.title
            cell.overviewLabel.text = moviesNow.overview
            cell.voteAverageLabel.text = String(moviesNow.voteAverage)
            cell.posterImage.load(url: url!)
        }
        
        
        return cell
    }
    
    //segue identifier: toMovieDetails
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "descri", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier=="descri", let indexPath = sender as? IndexPath {
            let destination = segue.destination as? MoviesDetailController
            
            if indexPath.section == 0 {

                
                let moviesPop = PopularMovies[indexPath.row]
                
                guard let imagePop = moviesAPI.getMoviePoster(with: URL(string: "https://image.tmdb.org/t/p/w500/\(moviesPop.posterPath)")) else { fatalError() }
                
                destination?.movieStr = MovieStruct.init(title: moviesPop.title, description: moviesPop.overview, genres: moviesPop.genreIds, rating: String(moviesPop.voteAverage), image: imagePop)
                
                
            }
            else if indexPath.section == 1 {
              
                let moviesNow = NowPlayingMovies[indexPath.row]
                
                guard let imageNow = moviesAPI.getMoviePoster(with: URL(string: "https://image.tmdb.org/t/p/w500/\(moviesNow.posterPath)")) else { fatalError() }
                
                destination?.movieStr = MovieStruct.init(title: moviesNow.title, description: moviesNow.overview, genres: moviesNow.genreIds, rating: String(moviesNow.voteAverage), image: imageNow)
            
            
            
            }
           
        }
    }
}
    extension UIImageView {
        func load(url: URL) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
