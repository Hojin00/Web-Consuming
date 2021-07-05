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
                
                
                
                moviesArray.append(Movie(title: title, voteAverage: voteAverage, overview: overview, genreIds: genreIds, posterPath: posterPath))
                
            }
            
            completionHandler(moviesArray)
        }
        .resume()
    }
    
    public func getMoviePoster(with url: URL?) -> UIImage? {
            guard let url = url, let data = try? Data(contentsOf: url) else { return nil }
            return UIImage(data: data)
        }
    
    func getMovies(get: String, page: Int, completionHandler: @escaping ([Movie]) -> Void){
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(get)?api_key=2f8e29176bab443251fb4a3303db7498&language=en-US&page=\(page)")!
        
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
            
                
                moviesArray.append(Movie(title: title, voteAverage: voteAverage, overview: overview, genreIds: genreIds, posterPath: posterPath))
                
            }
            completionHandler(moviesArray)
        }
        .resume()

    }
    
    func getGenres(genres: [Int], completionHandler: @escaping ([String]) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=2f8e29176bab443251fb4a3303db7498&language=en-US")!
        
        typealias genresTypes = [String: Any]
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                  let dictionary = json as? [String: Any],
                  let genresList = dictionary["genres"] as? [genresTypes]
            
            else { return }
            
            var genresArray: [String] = []
            
            for genreChosen in genres{
                
                for genre in genresList{
                    guard let id = genre["id"] as? Int,
                          let name = genre["name"] as? String
                    
                    else { return }
                    
                    if id == genreChosen{
                        genresArray.append(name)
                        
                    }
                }
            }
            
            completionHandler(genresArray)
        }
        .resume()
        
    }
}
