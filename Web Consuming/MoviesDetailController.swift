//
//  MoviesDetailController.swift
//  Web Consuming
//
//  Created by Hojin Ryu on 02/07/21.
//

import UIKit

class MoviesDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableDescription: UITableView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var poster: UIImageView!
    var movieStr : MovieStruct?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableDescription.dequeueReusableCell(withIdentifier: "descricao", for: indexPath) as? MoviesDetailsTableViewCell else{
            fatalError("MovieDetailsTableViewCell")
        }
        cell.descri.text = movieStr?.description
        
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDescription.dataSource = self
        tableDescription.delegate = self
        
        titulo.text = movieStr?.title
        rating.text = movieStr?.rating
        poster.image = movieStr?.image
        genres.text = "  " //!!!
        
        
    }
}
