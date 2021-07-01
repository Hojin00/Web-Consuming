//
//  ViewController.swift
//  Web Consuming
//
//  Created by Hojin Ryu on 01/07/21.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2f8e29176bab443251fb4a3303db7498&language=en-US&page=1")!
        
        typealias WebMovies = [String: Any]
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any],
                  let charactersDictionary = json as? [WebMovies]
            else {
                
                return
            }
            print(charactersDictionary)
            
        }
        .resume()
    }


}

