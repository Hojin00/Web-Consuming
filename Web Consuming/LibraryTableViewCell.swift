//
//  LibraryTableViewCell.swift
//  Web Consuming
//
//  Created by Heitor Feijó Kunrath on 01/07/21.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
