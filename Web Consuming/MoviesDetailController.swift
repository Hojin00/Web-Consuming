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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
