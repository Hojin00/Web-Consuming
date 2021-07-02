//
//  MovieService.swift
//  Web Consuming
//
//  Created by Hojin Ryu on 02/07/21.
//


import UIKit

struct Movie {
    let title: String
    let voteAverage: Double
    let overview: String
    let genreIds: [Int]
    let posterPath: String
    let posterImage: UIImage
}

struct MovieService {
    
    
}

struct MovieAPI {
    
    func getPopularMovie(page: Int, completionHandler: @escaping ([Movie]) -> Void){
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2f8e29176bab443251fb4a3303db7498&language=en-US&page=\(page)")!
        
        typealias PopularMovies = [String: Any]
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                  let dictionary = json as? [String: Any],
                  let movies = dictionary["results"] as? [PopularMovies]
            
            else { return }
            
            var moviesArray: [Movie] = []
            
            for movie in movies {
                guard let title = movie["title"] as? String,
                      let voteAverage = movie["vote_average"] as? Double,
                      let overview = movie["overview"] as? String,
                      let genreIds = movie["genre_ids"] as? [Int],
                      let posterPath = movie["poster_path"] as? String
                
                else { continue }
                
                guard let image = getMoviePoster(with: URL(string: "http://image.tmdb.org/t/p/w500/jTswp6KyDYKtvC52GbHagrZbGvD.jpg"))
                else { return }
                
                moviesArray.append(Movie(title: title, voteAverage: voteAverage, overview: overview, genreIds: genreIds, posterPath: posterPath, posterImage: image))
                
            }
            
            completionHandler(moviesArray)
        }
        .resume()
    }
    
    public func getMoviePoster(with url: URL?) -> UIImage? {
            guard let url = url, let data = try? Data(contentsOf: url) else { return nil }
            return UIImage(data: data)
        }
    
    func getNowPlayingMovie(page: Int, completionHandler: @escaping ([Movie]) -> Void){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=2f8e29176bab443251fb4a3303db7498&language=en-US&page=\(page)")!
        
        typealias NowPlayingMovies = [String: Any]
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                  let dictionary = json as? [String: Any],
                  let movies = dictionary["results"] as? [NowPlayingMovies]
            
            else { return }
            
            var moviesArray: [Movie] = []
            
            for movie in movies {
                guard let title = movie["title"] as? String,
                      let voteAverage = movie["vote_average"] as? Double,
                      let overview = movie["overview"] as? String,
                      let genreIds = movie["genre_ids"] as? [Int],
                      let posterPath = movie["poster_path"] as? String
                
                else { continue }
                
                guard let image = getMoviePoster(with: URL(string: "http://image.tmdb.org/t/p/w500/jTswp6KyDYKtvC52GbHagrZbGvD.jpg"))
                else { return }
                
                moviesArray.append(Movie(title: title, voteAverage: voteAverage, overview: overview, genreIds: genreIds, posterPath: posterPath, posterImage: image))
                
            }
            
            completionHandler(moviesArray)
        }
        .resume()

    }
}


