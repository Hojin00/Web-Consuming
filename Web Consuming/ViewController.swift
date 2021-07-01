//
//  ViewController.swift
//  Web Consuming
//
//  Created by Hojin Ryu on 01/07/21.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var moviesLibraryTable: UITableView!
    
    

    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        moviesLibraryTable.dataSource = self
        moviesLibraryTable.delegate = self
        
//        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2f8e29176bab443251fb4a3303db7498&language=en-US&page=1")!
//
//        typealias WebMovies = [String: Any]
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data,
//                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any],
//                  let charactersDictionary = json as? [WebMovies]
//            else {
//
//                return
//            }
//            print(charactersDictionary)
//
//        }
//        .resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesLibraryTable.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? LibraryTableViewCell else {
            fatalError("Não foi possivel converter a celula para MovieCell")
        }
        cell.movieDescription.text="oi"
        cell.rating.text="helle"
        cell.title.text = "dasd"
        cell.poster.image = UIImage(named: "")
        return cell
    }


}

